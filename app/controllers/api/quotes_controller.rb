class Api::QuotesController < ApplicationController

  def index
    @quotes = Quote.all.order_by([:random, :desc])
    render json: @quotes, root: "quotes"
  end

  def show
    @quote = Quote.find params[:id]
    render json: @quote, root: "quote"
  end
end
