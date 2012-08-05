class UserProfile
  include Mongoid::Document

  field :username
  field :first_name
  field :last_name

  embedded_in :user

end
