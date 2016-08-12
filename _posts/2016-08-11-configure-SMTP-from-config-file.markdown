---
layout: post
title:  Read SMTP Settings From Configuration File
date:   2016-08-11 14:00:00 -0700
categories: [SMTP, .NET]
tags: [SMTP, .NET]
githubUrl: https://github.com/cknightdevelopment/KnightCodesExamples/tree/master/DotNet/Smtp.Configuration
youtubeId: IcJhYsUikRc
---

Reading SMTP settings from a configuration file (e.g. app.config, web.config, etc.) is a simple process. This enables you to use the same settings across your entire project and only have to apply updates in one place.

### Overview

There are just two basic steps in the process:

1. Gather the required SMTP server information for your system. This information includes the server address, port number, SSL requirements, and username/password (if needed).
2. Add the SMTP settings to the `app.config` or `web.config` as a child of the `configuration` node.

### Basic Example

Assuming that I have already gathered the required SMTP server information (I'll use dummy values in this example), I am now going to add these setting as children of the `configuration` node in the configuration file:

```
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
    <startup> 
        <supportedRuntime version="v4.0" sku=".NETFramework,Version=v4.5" />
    </startup>

  <!-- Below are the SMTP settings -->
  <system.net>
    <mailSettings>
      <smtp from="fromAddress@domain.com">
        <network host="smtpEmailServerAddress" port="25" enableSsl="true"
            userName="username" password="password"/>
      </smtp>
    </mailSettings>
  </system.net>

</configuration>
```

Now that we have these setting is place, when I debug the code below we should see that the values from the coniguration file are being used to populate the properties in the `SmtpClient` and `MailMessage` objects:

```c#
using (SmtpClient client = new SmtpClient())
using (MailMessage message = new MailMessage())
{
    message.To.Add("toAddress@domain.com");
    message.IsBodyHtml = true;
    message.Subject = "Subject";
    message.Body = "Body";

    try
    {
        // send the email
        client.Send(message);
    }
    catch (SmtpException ex)
    {
        // log exception
    }
}
```

Below is a screenshot of the Locals window in Visual Studio while debugging and hitting a breakpoint at the `message.To.Add("toAddress@domain.com");` line above (see highlighted items below):

<img id="smtp-debugging" src="/assets/images/smtp-debugger.png" alt="SMTP debug session" /> 

### Final Thoughts

* If you are using a username and password in your configuration file, make sure it is for an account that does not have a password expiration. Otherwise you will need to update your config file every time the password changes.
* Developers often times have code where a list of users are passed to a method, which then loops through the user list and sends an email to each person. A common mistake in this scenario is to exit the loop when an exception occurs (e.g. if an email attempt to one user causes an exception, remaining in the list do not get processed). It is good practice to have an SMTP exception not stop your email loop, but rather log it, continue through the loop, and then address the exceptions when the loop finishes (unless of course you can't even reach the email server at all).