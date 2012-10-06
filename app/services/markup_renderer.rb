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
    options = {:no_intra_emphasis  => true, :tables  => true, :autolink  => true}
    unless configatron.markdown.table.css_class.nil?
      options.merge!({:table_css_class  => configatron.markdown.table.css_class})
    end
    @markdown ||= Redcarpet::Markdown.new(Kawa::Markdown::HtmlRenderer.new(options), options)
  end

end
