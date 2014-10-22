module ApplicationHelper
  #From Railscasts Ep. #272, and https://github.com/vmg/redcarpet
  #This will create a helper to render markdown in views
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new()
    markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    markdown.render(text)
  end
end
