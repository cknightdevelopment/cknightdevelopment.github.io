# Extra per-post data for the layouts:
# - `description` (used by the SEO plugin for search results and link previews) defaults to
#   `subtitle`, then `tldr`, then the first plain paragraph (Jekyll's default excerpt would
#   pick up call-out and quote markup).
# - `updated` front matter is copied to `last_modified_at`, which the SEO and sitemap plugins read.
# - `related`: up to 3 other posts sharing the most tags, newest first on ties.
module PostData
  NOT_PROSE = [">", "#", "-", "*", "+", "|", "<", "```", "{%"].freeze

  def self.first_paragraph(markdown)
    paragraph = markdown.split(/\n\s*\n/).map(&:strip).find do |block|
      !block.empty? && !block.start_with?(*NOT_PROSE) && !block.match?(/\A\d+\. /)
    end
    paragraph&.gsub(/!?\[([^\]]*)\]\([^)]*\)/, '\\1')&.gsub(/[*_`~]/, "")&.gsub(/\s+/, " ")
  end
end

Jekyll::Hooks.register :site, :post_read do |site|
  posts = site.posts.docs
  posts.each do |post|
    post.data["description"] ||= post.data["subtitle"] || post.data["tldr"] || PostData.first_paragraph(post.content)
    post.data["last_modified_at"] ||= post.data["updated"] if post.data["updated"]

    tags = post.data["tags"]
    post.data["related"] = posts
      .reject { |other| other.equal?(post) }
      .map { |other| [other, (other.data["tags"] & tags).size] }
      .select { |_, shared| shared.positive? }
      .sort_by { |other, shared| [-shared, -other.date.to_f] }
      .first(3)
      .map(&:first)
  end
end
