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


  def self.label(*labels)
    labels.each {|label| define_label(label) }
  end

  def self.define_label(label)
    define_method label do
      labels[label.to_s]
    end

    define_method "#{label}=" do |label_value|
      set_label(label.to_s, label_value)
    end
  end

  def set_label(key, value)
    self.labels = {} unless labels
    labels[key] = value.strip if value
  end

  
end
