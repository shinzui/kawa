module BasePresenter
  include Kawa::Common::Presenter

  def tags
    model.tags
  end

  def tags?
    tags.present?  
  end

  def updatable?
    h.current_or_guest_user.can_update?(model)
  end

  def deletable?
    h.current_or_guest_user.can_delete?(model)
  end

  def private?
    model.respond_to?(:private?) ? model.private? : false
  end

  def backlinks
    model.respond_to?(:inbound_page_links) ? model.inbound_page_links : []
  end

  def backlinks?
    backlinks.present?
  end

  def view_count
    if model.respond_to?(:visits)
      count = model.visits.count
      h.content_tag(:span, "#{h.pluralize(count, 'visit')}")
    end
  end

  def created_at
    return unless model.created_at
    h.content_tag(:strong, "Created on: ") +
    time_tag(model.created_at)
  end

  def creator
    return unless owner
    h.content_tag(:strong, "by: ") +
    h.content_tag(:span, owner + ". ")
  end

  def updated_at
    return if model.updated_at.nil? || model.updated_at == model.created_at
    h.content_tag(:strong, "Last updated on: ") +
    time_tag(model.updated_at)
  end

  def time_tag(datetime)
    h.content_tag(:time, :datetime  => I18n.l(datetime, :format  => :html5)) do
      h.concat(h.content_tag(:em, I18n.l(datetime, :format  => :long)))
    end
  end
end
