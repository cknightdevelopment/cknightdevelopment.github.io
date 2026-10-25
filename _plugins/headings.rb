# Adds a "#" link to each h2-h4 in posts and pages, and, when front matter has
# `toc: true`, a table of contents built from the h2/h3 headings.
module Headings
  PATTERN = %r{<h([2-4]) id="([^"]+)">(.*?)</h\1>}m

  def self.render(html, toc:)
    entries = []
    html = html.gsub(PATTERN) do
      level, id, text = Regexp.last_match(1).to_i, Regexp.last_match(2), Regexp.last_match(3)
      entries << [level, id, text.gsub(/<[^>]+>/, "")] if level <= 3
      %(<h#{level} id="#{id}">#{text}<a href="##{id}" class="heading-anchor" aria-hidden="true" tabindex="-1">#</a></h#{level}>)
    end
    return html unless toc && entries.any?

    items = entries.map { |level, id, text| %(<li class="toc-h#{level}"><a href="##{id}">#{text}</a></li>) }
    %(<nav class="toc" aria-label="Table of contents"><p class="toc-title">On this page</p><ul>#{items.join}</ul></nav>\n#{html})
  end
end

Jekyll::Hooks.register [:documents, :pages], :post_convert do |doc|
  doc.content = Headings.render(doc.content, toc: doc.data["toc"]) if doc.content.include?("<h")
end
