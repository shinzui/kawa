require 'spec_helper'

describe Quote do

  let(:author)  { "Author" } 

  describe "Initialization" do
    it "should set a random number if not present" do
      Quote.any_instance.stub(:rand).and_return(0.33)
      Fabricate.build(:quote).random.should == 0.33
      Fabricate.build(:quote, :random  => 0.99).random.should == 0.99
    end
  end
  
  describe "Initializing" do
    it "should have an empty labels hash" do
      Quote.new.labels.should_not be_nil
    end


    it "should support initializing with attributes" do
      quote = Quote.new({:author  => "Author"})
      quote.author.should == author
    end

  end

  describe "#author=" do
    it "should self the author label" do
      q = Quote.new
      q.author = author
      q.labels["author"].should == author
    end
  end

  describe ".random" do
    before :each do
      @quote1 = Fabricate(:quote, :random  => 0.57)
      @quote2 = Fabricate(:quote, :random  => 0.33)
    end

    context "with no quote with random value greater then rand" do
      it "should return a random quote" do
        Quote.stub!(:rand).and_return(0.6)
        Quote.random.should == @quote1
      end
    end

    it "should return a random quote" do
      Quote.stub!(:rand).and_return(0.5)
      Quote.random.should == @quote1
    end
  end
end
