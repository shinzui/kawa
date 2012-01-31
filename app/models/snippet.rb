class Snippet
  include Mongoid::Document
  include Mongoid::Timestamps

  include Mongoid::TaggableWithContext
  include Mongoid::TaggableWithContext::AggregationStrategy::RealTime

  after_initialize { self.labels = {} unless labels }

  taggable :tags, :separator  => ","

  field :labels, :type  => Hash
  field :data

  validates_presence_of :data

  def set_label(key, value)
    self.labels = {} unless labels
    labels[key] = value
  end
end
