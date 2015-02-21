module Jekyll
  class RenderPostImageTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
    end

    def render(context)
      url     = context.environments.first["site"]["url"]
      baseurl = context.environments.first["site"]["baseurl"]
      %Q(<a href="#{url}#{baseurl}/images/posts/#{@text}"><img src="#{url}#{baseurl}/images/posts/#{@text}" alt=""></a>)
    end
  end
end

Liquid::Template.register_tag('render_post_image', Jekyll::RenderPostImageTag)
