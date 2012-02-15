class Visit
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :ip
  field :referrer

  belongs_to :link
end
