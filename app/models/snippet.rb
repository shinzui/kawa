class Snippet
  include Mongoid::Document
  include Mongoid::Timestamps

  include Mongoid::TaggableWithContext
  include Mongoid::TaggableWithContext::AggregationStrategy::RealTime

  include SnippetLabel

  after_initialize { self.labels = {} unless labels }

  taggable :tags, :separator  => ","

  field :data

  validates_presence_of :data

  label :lang

  def self.supported_languages
    lang = Struct.new(:lang, :lang_code)
    [lang.new("English", :en), lang.new("Japanese", :ja), lang.new("French", :fr), lang.new("Korean", :ko)]
  end

end
