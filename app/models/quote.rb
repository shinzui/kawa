class Quote 
  include Snippet

  include Authority::Abilities

  field :random, type: Float

  index({random: 1})

  belongs_to :contributor, :class_name  => "User"

  alias :quotation :data
  alias :quotation= :data=

  label :author, :source, :source_url

  after_initialize { self.random ||= rand }

  self.authorizer_name = "ResourceAuthorizer"

  def self.random(tags = nil)
    rv = rand
    quote =  where(:random.gte => rv).order_by([:random, :asc]).first
    quote ||= where(:random.lte  => rv).order_by([:random, :desc]).first
  end

end
