class Page
  include Mongoid::Document
  include Mongoid::Slug
  include Tire::Model::Search
  include Tire::Model::Callbacks

  index_name "#{Rails.env}-#{Rails.application.class.to_s.downcase}-pages"

  module Markup
    MARKDOWN = "markdown".freeze
    CREOLE   = "creole".freeze
  end
  
  field :name
  field :markup
  field :raw_data
  slug :name

  validates_presence_of :name, :markup, :raw_data
  validates_uniqueness_of :name

	def	self.supported_markups
		Markup.constants.map {|m| Markup.const_get(m)}
	end

  def self.search_index
    Tire.index(index_name)
  end

  def self.create_search_index
    search_index.create unless search_index.exists?
  end

  def self.elastic_search(query_str)
    tire.search(load: true) do
      query { string query_str } if query_str.present?
    end
  end

end
