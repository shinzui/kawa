require 'spec_helper'

describe Quote do

  let(:author)  { "Author" } 
  
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

end
