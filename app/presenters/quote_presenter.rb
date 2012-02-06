class QuotePresenter
  include Kawa::Common::Presenter
  include BasePresenter

  delegate :id, :author, :source, :quotation, :to  => :@model
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def quote
    blockquote_opts = {:lang  => @model.lang} if @model.lang.present?
    h.content_tag(:blockquote, blockquote_opts) do
      h.concat(quotation)
      h.concat(attribution)
    end
  end

  def attribution
    if author
      attribution = "#{author}"
      attribution << " in #{source} " unless source.empty?
      h.content_tag(:small, attribution)
    end
  end

  def to_s
    quote
  end

end
