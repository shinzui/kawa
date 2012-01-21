class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  include Tire::Model::Search
  include Tire::Model::Callbacks

  include Mongoid::TaggableWithContext
  include Mongoid::TaggableWithContext::AggregationStrategy::RealTime

  index_name "#{Rails.env}-#{Rails.application.class.to_s.downcase}-pages"

  taggable :tags, :separator  => ","

  before_save :process_plugins

  scope :named, ->(name) { where(name: /^#{name}$/i) }

  module Markup
    MARKDOWN = "markdown".freeze
    CREOLE   = "creole".freeze
  end
  
  field :name
  field :markup
  field :raw_data
  index :name, unique: true
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

  private
  
  def process_plugins
    Kawa::Wiki::Plugin::Processor.new(self).process_processing_plugins(raw_data)
  end

end
