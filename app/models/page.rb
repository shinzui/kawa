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
  before_save :extract_links

  has_and_belongs_to_many :links

  scope :named, ->(name) { where(name: /^#{name}$/i) }

  module Markup
    MARKDOWN = "markdown".freeze
    # CREOLE   = "creole".freeze
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

  def formatted_data(renderer = PageRenderer.new(self))
    #TODO cache result
    renderer.render
  end

  def title
    header = embedded_header
    header.empty? ? name : Loofah.fragment(header.to_html).scrub!(:strip).text
  end

  def embedded_header
    doc = Nokogiri::HTML(%{<div id="kawa-root">} + formatted_data + %{</div>})
    header = doc.css("div#kawa-root > h1:first-child")
  end

  private
  
  def process_plugins
    Kawa::Wiki::Plugin::Processor.new(self).process_processing_plugins(raw_data)
  end

  def extract_links
    doc = Nokogiri::HTML.parse(formatted_data)
    path = Rails.application.routes.url_helpers.short_url_path("id").gsub("id","")
    link_ids = doc.css('a').map { |a| a['href'] }.map { |l| l[%r|#{path}(.*)|, 1] }
    page_links = Link.find(link_ids.compact)
    self.links = page_links 
  end

end
