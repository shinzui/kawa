class QuotesController < ApplicationController
  before_filter :load_quote, :set_crumb, :only  => [:show, :edit, :update]

  def index
    add_crumb "Quotes"

    if TagSearchPresenter.tag_search?(params)
      @search = TagSearchPresenter.new(Quote, params)
      add_crumb @search.search_tags
      @quotes = @search.result
    else
      @quotes = Quote.all
    end
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(params[:quote])

    if @quote.save
      redirect_to @quote, :notice  => "Quote added successfully"
    else
      render :new
    end
  end

  def show
    @quote = QuotePresenter.new(@quote)
  end

  def edit
  end

  def update
    if @quote.update_attributes(params[:quote])
      redirect_to @quote, :notice  => "Quote updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @quote = Quote.find(params[:id])
    @quote.destroy
    redirect_to quotes_path
  end

  private

  def load_quote
    @quote = Quote.find(params[:id])
  end

  def set_crumb
    add_crumb "Quote"
  end
end
