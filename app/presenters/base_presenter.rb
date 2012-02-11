module BasePresenter
  include Kawa::Common::Presenter

  def tags
    model.tags_array
  end

  def tags?
    tags.present?  
  end

  def created_at
    return unless model.created_at
    h.content_tag(:strong, "Created on: ") +
    time_tag(model.created_at)
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
