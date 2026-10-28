# Makes every link to another site open in a new tab, site-wide (content, layouts, includes),
# and tells screen readers so. Links to this site's own domain are left alone.
module ExternalLinks
  LINK = %r{<a\s([^>]*\bhref="https?://([^/"]+)[^"]*"[^>]*)>(.*?)</a>}m

  def self.render(html, own_host)
    html.gsub(LINK) do
      attrs, host, text = Regexp.last_match(1), Regexp.last_match(2), Regexp.last_match(3)
      next Regexp.last_match(0) if host == own_host || attrs.include?("target=")

      %(<a #{attrs} target="_blank" rel="noopener noreferrer">#{text}<span class="sr-only"> (opens in a new tab)</span></a>)
    end
  end
end

Jekyll::Hooks.register [:documents, :pages], :post_render do |doc|
  next unless doc.output_ext == ".html"

  own_host = URI(doc.site.config["url"].to_s).host
  doc.output = ExternalLinks.render(doc.output, own_host)
end
