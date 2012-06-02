module SnippetLabel
  extend ActiveSupport::Concern

  included do
    field :labels, :type  => Hash
  end

  def set_label(key, value)
    self.labels = {} unless labels
    labels[key] = value.strip if value
  end

  module ClassMethods

    def declared_labels
      @declared_labels ||=[]
    end

    def declared_labels=(labels)
      @declared_labels = labels 
    end

    def label(*labels)
      self.declared_labels |= labels
      labels.each {|label| define_label(label) }
    end

    def define_label(label)
      define_method label do
        labels[label.to_s]
      end

      define_method "#{label}=" do |label_value|
        set_label(label.to_s, label_value)
      end
    end
  end

end
