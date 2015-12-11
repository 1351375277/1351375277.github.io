require 'redcarpet'

class LazysizesImg < Redcarpet::Render::HTML
  def image(link, title, alt_text)
    "<img data-src='#{link}' class='lazyload' />"
  end
end

class Jekyll::Converters::Markdown::Lazysizes
  def initialize(config)
    @config = config
    @converter = Redcarpet::Markdown.new(LazysizesImg, extensions = {})
  end

  def convert(content)
    @converter.render(content)
  end
end