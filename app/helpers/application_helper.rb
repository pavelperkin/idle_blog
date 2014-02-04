module ApplicationHelper
  def e(*args, &block)
    escape_javascript *args, &block
  end

  def markdown
    Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end
end
