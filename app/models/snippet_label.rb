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
    def label(*labels)
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
