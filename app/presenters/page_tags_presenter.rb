class PageTagsPresenter
  include Enumerable

  Tag = Struct.new(:name, :weight)

  def initialize(term = nil)
    @term = term
    @tags = filtered_tags  #term.nil? ? Page.tags_with_weight : Page.tags_with_weight(:criteria  => {:_id  => /#{term}/i})
  end

  def tags
    tags = []
    @tags.each do |tag|
      tags << Tag.new(tag.first, tag.last)
    end
    tags
  end

  def each
    tags.each { |e| yield(e) }
  end

  private
  def filtered_tags
    if @term.present?
      #temp hack to finish the rails4 upgrade, refactor and do inside db
      Page.tags_with_weight.select { |t| t.first =~ /#{@term}/i }
    else
      Page.tags_with_weight
    end
  end
  
end
