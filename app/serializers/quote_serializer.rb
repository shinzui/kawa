class QuoteSerializer < ActiveModel::Serializer
  attributes :id, :tags, :quotation, :author, :source, :source_url, :lang

  def id
    object.id.to_s
  end

end
