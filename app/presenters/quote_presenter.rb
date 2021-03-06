class QuotePresenter
  include BasePresenter

  delegate :id, :author, :source, :source_url, :quotation, :to  => :@model
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def owner
    UserPresenter.new(model.contributor).display_name
  end

  def quote
    blockquote_opts = {:lang  => @model.lang} if @model.lang.present?
    h.content_tag(:blockquote, blockquote_opts) do
      h.concat(h.simple_format(quotation))
      h.concat(attribution)
    end
  end

  def attribution
    if author
      attribution = "#{author}"
      attribution << ", #{attribution_source}" unless attribution_source.nil?
      h.content_tag(:small, attribution.html_safe)
    end
  end

  def attribution_source
    if source.present?
      source_url.present? ?  h.link_to(source, source_url) : source
    end
  end

  def to_s
    quote
  end

end
