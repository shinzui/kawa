class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  include Tire::Model::Search
  include Tire::Model::Callbacks

  include Mongoid::TaggableWithContext
  include Mongoid::TaggableWithContext::AggregationStrategy::RealTime

  include Authority::Abilities

  index_name "#{Rails.env}-#{Rails.application.class.to_s.downcase}-pages"

  taggable :tags, :separator  => ","

  before_save :process_plugins
  before_save :extract_links
  before_validation :set_default_markup

  has_and_belongs_to_many :links
  belongs_to :author, :class_name  => "User"
  belongs_to :last_editor, :class_name  => "User"

  scope :named, ->(name) { where(name: /^#{name}$/i) }
  scope :private, -> { where(private: true) }
  scope :authored, ->(author) { where(author_id: author.id) }
  scope :tagged, ->(tags) { all_in(tags_array: tags)}

  module Markup
    MARKDOWN = "markdown".freeze
    # CREOLE   = "creole".freeze
  end
  
  field :name
  field :markup
  field :raw_data
  field :private, type: Boolean
  field :_slugs, type: Array, default: []
  index({name: 1}, {unique: true})
  slug  :name do |current_object|
    Kawa::Util::SlugBuilder.generate(current_object.slug_builder)
  end

  validates_presence_of :name, :markup, :raw_data, :author
  validates_uniqueness_of :name

  self.authorizer_name = "ResourceAuthorizer"

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
    page_links = PageLinkExtractor.new(self).extract_links
    page_links.each {|l| l.associate_to_page(self)}
    self.links = page_links
  end

  def set_default_markup
    self.markup ||= Markup::MARKDOWN
  end

end
