class LinkAuthorizer < ResourceAuthorizer

  def deletable_by?(user)
    super && resource.can_destroy?
  end

end
