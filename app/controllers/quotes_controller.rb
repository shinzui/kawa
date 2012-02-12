class QuotesController < KawaController

  def show
    @quote = QuotePresenter.new(@quote)
  end

end
