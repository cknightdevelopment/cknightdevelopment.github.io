# Turns GitHub-style alert blockquotes into styled call-outs:
#
#   > [!TIP] Optional custom title
#   > Body text, **markdown** works.
#
# Types: NOTE, TIP, IMPORTANT, WARNING, CAUTION.
module Callouts
  TYPES = %w[NOTE TIP IMPORTANT WARNING CAUTION].freeze
  PATTERN = %r{<blockquote>\s*<p>\[!(#{TYPES.join("|")})\][ \t]*([^\n<]*)\n?(.*?)</blockquote>}m

  def self.render(html)
    html.gsub(PATTERN) do
      type = Regexp.last_match(1).downcase
      title = Regexp.last_match(2).strip
      title = type.capitalize if title.empty?
      body = "<p>#{Regexp.last_match(3)}".sub(%r{\A<p>\s*</p>\s*}, "")
      %(<div class="callout callout-#{type}"><p class="callout-title">#{title}</p>#{body}</div>)
    end
  end
end

Jekyll::Hooks.register [:documents, :pages], :post_convert do |doc|
  doc.content = Callouts.render(doc.content) if doc.content.include?("[!")
end
