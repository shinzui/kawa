class SearchPresenter
  include Kawa::Common::Presenter

  attr_reader :query

  def initialize(query)
    @query = query.chomp
    results
  end

  def results
    @pages ||= begin
      pages = Page.elastic_search(query)
    end
  end

  def results?
    !results.empty?
  end

  def exact_match
    @exact_match ||= Page.named(query).first
  end

  def exact_match?
    !exact_match.nil? 
  end

  def new_page_link_from_query(html_options = {})
    h.link_to "Create #{query}", h.new_page_path(:page  => {:name  => query}), html_options
  end
end
