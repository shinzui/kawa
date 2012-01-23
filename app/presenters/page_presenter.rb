# encoding: UTF-8
class PagePresenter
  include Kawa::Common::Presenter

  delegate :name, :to  => :@model
  attr_reader :model

  def initialize(page)
    @model = page
  end

  def title
    "川 - #{@model.title}"
  end

  def header
    h.content_tag(:h1, @model.title) if @model.title == @model.name
  end

  def tags
    @model.tags_array
  end

  def tags?
    tags.present?  
  end

  def data
    @model.formatted_data
  end

  def created_at
    return unless @model.created_at
    h.content_tag(:strong, "Created on:") +
    h.content_tag(:em, I18n.l(@model.created_at, :format  => :long))
  end

  def updated_at
    return if @model.updated_at.nil? || @model.updated_at == @model.created_at
    h.content_tag(:strong, "Last updated on:") +
    h.content_tag(:em, I18n.l(@model.updated_at, :format  => :long))
  end

end
