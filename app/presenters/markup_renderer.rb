module MarkupRenderer
  extend self

  def renderers
    {
      :markdown => Proc.new {|content| markdown.render(content) },
      :creole   => Proc.new {|content| Creole.creolize(content) }
    }.with_indifferent_access
  end

  def renderer(format)
    renderers[format]
  end

  def markdown
    options = {:no_intra_emphasis  => true, :tables  => true}
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
  end


end
