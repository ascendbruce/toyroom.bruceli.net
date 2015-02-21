module Jekyll
  class RenderFullUrlTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
      config = Jekyll.configuration({})
      @url = config["url"]
      @baseurl = config["baseurl"]
    end

    def render(context)
      [@url, @baseurl, @text].join
    end
  end
end

Liquid::Template.register_tag('render_full_url', Jekyll::RenderFullUrlTag)
