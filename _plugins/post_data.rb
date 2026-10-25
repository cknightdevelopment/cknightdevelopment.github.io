# Extra per-post data for the layouts:
# - `updated` front matter is copied to `last_modified_at`, which the SEO and sitemap plugins read.
# - `related`: up to 3 other posts sharing the most tags, newest first on ties.
Jekyll::Hooks.register :site, :post_read do |site|
  posts = site.posts.docs
  posts.each do |post|
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
