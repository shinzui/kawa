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

end
