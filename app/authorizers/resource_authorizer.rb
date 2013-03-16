class ResourceAuthorizer < ApplicationAuthorizer

  UnsupportedResource = Class.new(StandardError)

  def resource_owner
    {
      Page  => Page.public_instance_method(:author),
      Link  => Link.public_instance_method(:creator),
      Bookmark  => Bookmark.public_instance_method(:creator),
      Quote  => Quote.public_instance_method(:contributor)
    }.freeze
  end

  def self.readable_by?(user)
    return true
  end

  def modifiable_by?(user)
    raise UnsupportedResource unless resource_owner.keys.include?(resource.class)

    return true unless resource.respond_to?(:private?) && resource.private? 
    owner = resource_owner[resource.class].bind(resource).call
    return owner == user
  end

  def readable_by?(user)
    modifiable_by?(user)
  end

  def updatable_by?(user)
    modifiable_by?(user) && not_guest?(user)
  end

  def deletable_by?(user)
    modifiable_by?(user) && not_guest?(user)
  end

  def creatable_by?(user)
    not_guest?(user)
  end

  protected 
  def not_guest?(user)
    !user.is_a?(GuestUser)
  end

end
