require 'spec_helper'

module Kawa::Mongo
  describe Sequence do

    context "with missing document" do
      it "should create it and return the first value" do
        Sequence.next("random").should == 1
      end
    end

    it "should be incremented on every call" do
      Sequence.next("seq").should == 1
      Sequence.next("seq").should == 2
      Sequence.next("seq").should == 3
    end
  end
end
