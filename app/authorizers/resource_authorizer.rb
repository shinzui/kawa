class ResourceAuthorizer < ApplicationAuthorizer

  UnsupportedResource = Class.new(StandardError)

  ResourceOwner = {
    Page  => Page.public_instance_method(:author),
    Link  => Link.public_instance_method(:creator),
    Bookmark  => Bookmark.public_instance_method(:creator)
  }.freeze

  def self.readable_by?(user)
    return true
  end

  def modifiable_by?(user)
    raise UnsupportedResource unless ResourceOwner.keys.include?(resource.class)

    return true unless resource.private?
    owner = ResourceOwner[resource.class].bind(resource).call
    return owner == user
  end

  def readable_by?(user)
    modifiable_by?(user)
  end

  def updatable_by?(user)
    modifiable_by?(user)
  end

  def deletable_by?(user)
    modifiable_by?(user)
  end

end
