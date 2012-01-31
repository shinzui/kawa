class QuotePresenter
  include Kawa::Common::Presenter
  include BasePresenter

  delegate :author, :source, :quotation, :to  => :@model
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def attribution
    if author
      attribution = "#{author}"
      attribution << " in #{source} " unless source.empty?
      h.content_tag(:small, attribution)
    end
  end

end
