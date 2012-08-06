require 'spec_helper'

describe Kawa::Wiki::Engine do

  let(:engine) { Kawa::Wiki::Engine.instance }

  describe ".add_page" do
    before :each do
      @page = Fabricate.build(:page, :author  => nil)
      @author = Fabricate.build(:user)
    end

    it "should set the page's author" do
      @page.author.should be_nil
      @page.stub(:save)
      engine.add_page(@author, @page)
      @page.author.should == @author
    end

    it "should save the page" do
      @page.should_receive(:save)
      engine.add_page(@author, @page)
    end
  end
end

