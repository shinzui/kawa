class PageTagsPresenter
  include Enumerable

  Tag = Struct.new(:name, :weight)

  def initialize(term = nil)
    @tags = term.nil? ? Page.tags_with_weight : Page.tags_with_weight(:criteria  => {:_id  => /#{term}/i})
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
  
end
