require "digest"

# Liquid filter: {{ tag | tag_color }} returns a color name for the tag's `.tag-<color>` class.
# Colors come from _data/tag_colors.yml when set there, otherwise from a hash of the tag
# name, so a tag keeps the same color everywhere. Keep COLORS in sync with _css/main.css.
module TagColors
  COLORS = %w[sky violet amber rose teal indigo orange pink].freeze

  def tag_color(tag)
    name = tag.to_s.downcase
    overrides = @context.registers[:site].data["tag_colors"] || {}
    overrides[name] || COLORS[Digest::MD5.hexdigest(name).to_i(16) % COLORS.size]
  end
end

Liquid::Template.register_filter(TagColors)
