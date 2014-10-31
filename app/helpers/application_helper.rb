module ApplicationHelper

  class PygmentsHTML < Redcarpet::Render::HTML
    def block_code code, language
      Pygments.highlight(code, :lexer => language)
    end
  end

  def markdown(text)
    renderer = PygmentsHTML.new(
      with_toc_data: true,
      hard_wrap: true
    )
    options = {
      :no_intra_emphasis => true,
      :tables => true,
      :fenced_code_blocks => true,
      :autolink => true,
      :strikethrough => true,
      :lax_spacing => true,
      :superscript => true
    }
    markdown = Redcarpet::Markdown.new(renderer, options)
    markdown.render(text).html_safe
  end

  #From Railscasts Ep. #272, and https://github.com/vmg/redcarpet
  #This will create a helper to render markdown in views
#  def markdown(text)
#    renderer = Redcarpet::Render::HTML.new()
#    markdown = Redcarpet::Markdown.new(renderer, extensions = {})
#    markdown.render(text)
#  end
end
