class PageInfoSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :created_at, :updated_at, :private

  def id
    object.id.to_s
  end

end
