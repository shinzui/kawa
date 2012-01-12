class PageTagsPresenter
  include Enumerable

  Tag = Struct.new(:name, :weight)

  def initialize
  end

  def tags
    tags = []
    Page.tags_with_weight.each do |tag|
      tags << Tag.new(tag.first, tag.last)
    end
    tags
  end

  def each
    tags.each { |e| yield(e) }
  end
  
end
