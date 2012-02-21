class QuotesController < KawaController

  def show
    @quote = QuotePresenter.new(@quote)
  end

  protected

  def all
    Quote.all.order_by([:random, :desc])
  end

end
