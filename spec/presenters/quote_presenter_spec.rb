require 'spec_helper'

describe QuotePresenter do
  before :each do
    ApplicationController.new.set_current_view_context       
  end

  describe ".attribution" do
    context "quote without source" do
      before :each do
        @quote = Fabricate.build(:quote, "author"  => "Miyamoto Musashi", "source"  => "")
        @presenter = QuotePresenter.new(@quote)
      end

      it "should have the author" do
        @presenter.attribution.should eq "<small>#{@quote.author}</small>"
      end
    end

    context "quote with source" do
      before :each do 
        @quote = Fabricate.build(:quote, "author"  => "Miyamoto Musahi", "source"  => "The Book of Five Rings")
        @presenter = QuotePresenter.new(@quote)
      end

      it "should have the source" do
        @presenter.attribution.should == "<small>#{@quote.author} in #{@quote.source}</small>"
      end

      it "should have the source url if present" do
        @quote.source_url = "http://bookoffiverings.com"
        @presenter.attribution.should == "<small>#{@quote.author} in <a href=\"#{@quote.source_url}\">#{@quote.source}</a></small>"
      end
    end

    context "quote without author" do
      before :each do
        @quote = Fabricate.build(:quote)
        @presenter = QuotePresenter.new(@quote)
      end

      it "should not have an attribution" do
        @presenter.attribution.should be_nil
      end
    end
  end
end
