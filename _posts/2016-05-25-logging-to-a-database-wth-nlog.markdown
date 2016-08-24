---
layout: post
title:  Logging To A Database With NLog
date:   2016-05-25 14:00:00 -0700
categories: [.NET]
tags: [NLog, .NET]
githubUrl: https://github.com/cknightdevelopment/KnightCodesExamples/tree/master/DotNet/NLog.Database
youtubeId: N9qioGSSzes
---

Expanding upon my previous post [Logging To A File With NLog](http://knightcodes.com/.net/2016/05/20/logging-to-a-file-with-nlog.html){:target="_blank"}, updating our configuration to have NLog log to a database is easy. If you have not already seen that post, please give it a read before continuing on. Otherwise let’s get started. 

### Overview

There are a few steps to have NLog begin logging to a database (very similar to logging to a file):

1. Install the `NLog` and `NLog.Config` package into our project via NuGet in Visual Studio
2. Add a connection string to our configuration file for the database we want to connect to
3. Create the table that will hold our exception data and the stored procedure NLog will call to insert the exception data
4. Add a logging target to `NLog.config` (this file is added automatically when the NuGet packages are installed)
5. Add a logger to `NLog.config` that utilizes the target we created
6. Create a new `Logger` object and use the methods it provides

### Basic Example

For our example we are going to configure NLog to log exceptions to a database table using a stored procedure. We could just as easily configured it to perform trace logging, log warning messages, etc., but this will give us a basic understanding.

#### Install NuGet Packages

The first thing we need to do is install the `NLog` and `NLog.Config` packages into our project via NuGet. This will add the NLog library to the project references, as well as the NLog.config (and the corresponding XML schema `NLog.xsd`) that is used to configure NLog. 

#### Add Connection String

Now we need to add a connection string to our configuration file (e.g. `app.config`) for the database that we want to connect to. There is nothing special about this connection string, however take note of the `name` attribute because we will make reference to it later. In our example it is named `NLog`:

```xml
<connectionStrings>
    <!-- update this connection string to work for your database -->
    <add name="NLog" connectionString="Data Source=.\;Initial Catalog=MyDatabase;Integrated Security=true;" providerName="System.Data.SqlClient" />
</connectionStrings>
```

#### Create Exception Table And Stored Procedure

We now need to create the table that will hold our exception data and the stored procedure that will insert data into this table. We will create a SQL table named `dbo.Logs` and a stored procedure named `dbo.InsertLog`. The `LogId` and `LoggedOnDate` columns will get default values and the rest of the columns will come from the stored procedure parameters.

```sql
/*
	Create Logs table to hold exception data

	NOTE: I am using varchar(max) because I am being lazy, use whatever lengths are appropriate for you
*/

create table [dbo].[Logs](
	[LogId] [int] IDENTITY(1,1) not null,
	[Level] [varchar](max) not null,
	[CallSite] [varchar](max) not null,
	[Type] [varchar](max) not null,
	[Message] [varchar](max) not null,
	[StackTrace] [varchar](max) not null,
	[InnerException] [varchar](max) not null,
	[AdditionalInfo] [varchar](max) not null,
	[LoggedOnDate] [datetime] not null constraint [df_logs_loggedondate]  default (getutcdate()),

	constraint [pk_logs] primary key clustered 
	(
		[LogId]
	)
)

GO

/*
	Create InsertLog stored procedure
*/

alter procedure [dbo].[InsertLog] 
(
	@level varchar(max),
	@callSite varchar(max),
	@type varchar(max),
	@message varchar(max),
	@stackTrace varchar(max),
	@innerException varchar(max),
	@additionalInfo varchar(max)
)
as

insert into dbo.Logs
(
	[Level],
	CallSite,
	[Type],
	[Message],
	StackTrace,
	InnerException,
	AdditionalInfo
)
values
(
	@level,
	@callSite,
	@type,
	@message,
	@stackTrace,
	@innerException,
	@additionalInfo
)

go
```

#### Configure Target and Logger

We will now add configuration settings to have NLog call our `dbo.InsertLog` stored procedure.

_Note: this is only showing the `targets` and `rules` nodes of the `NLog.config`_

```xml
<targets>  
    <!-- database target -->
    <target name="database" 
            xsi:type="Database"
            connectionStringName="NLog"
            commandText="exec dbo.InsertLog
                            @level,
                            @callSite,
                            @type,
                            @message,
                            @stackTrace,
                            @innerException,
                            @additionalInfo">
            <parameter name="@level" layout="${level}" />
            <parameter name="@callSite" layout="${callsite}" />
            <parameter name="@type" layout="${exception:format=type}" />
            <parameter name="@message" layout="${exception:format=message}" />
            <parameter name="@stackTrace" layout="${exception:format=stackTrace}" />
            <parameter name="@innerException" 
                        layout="${exception:format=:innerFormat=ShortType,Message,Method:MaxInnerExceptionLevel=1:InnerExceptionSeparator=}" />
            <parameter name="@additionalInfo" layout="${message}" />
    </target>
</targets>
	
<rules>
    <!-- database logger -->
    <logger levels="Error,Warn,Fatal" name="databaseLogger" writeTo="database"/>
</rules>
```

The target we created is named `database` with a target type of `Database`. We provide `NLog` as the name of the connection string that we want it to use (added in a previous step) and tell it to execute our stored procedure as it's command text. The parameter data used when the stored procedure gets called is provided by the `<parameter>` nodes, which we set to NLog exception properties. Refer to the [NLog project site](http://nlog-project.org/){:target="_blank"} for specifics on these properties.

The logger we created is named `databaseLogger` and it will log messages that have the logging severity level of `Error`, `Warn`, or `Fatal` (NLog severity levels from least to greatest are `Trace`, `Debug`, `Info`, `Warn`, `Error`, and `Fatal`). Our logger will use the `database` target that we added.

#### .NET Code

All we need to do now is write some .NET code that will use our configured target and logger. Create an instance of the `Logger` object provided by the NLog API by calling `LogManager.GetLogger()` and specifying that we want to use our new `databaseLogger` logger.

```c#
try
{
    int zero = 0;
    int result = 5 / zero;
}
catch (DivideByZeroException ex)
{
    // get a Logger object and log exception here using NLog. 
    // this will use the "databaseLogger" logger from our NLog.config file
    Logger logger = LogManager.GetLogger("databaseLogger");

    // add custom message and pass in the exception
    logger.Error(ex, "Whoops!");
}
```

If all went well a row should have been inserted into the `dbo.Logs` table with the exception data. 

<img id="nlog-database-result" src="/assets/images/nlog-database-result.png" alt="NLog database result" /> 