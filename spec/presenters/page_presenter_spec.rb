require 'spec_helper'

describe PagePresenter do

  before :each do
    ApplicationController.new.set_current_view_context       
  end

  describe ".header" do
    context "page without headline" do

      before :each do
        @page = Fabricate.build(:markdown_page, :raw_data  => "### Test") 
        @presenter = PagePresenter.new(@page)
      end

      it "should return the page name in an h1" do
        @presenter.header.should == "<h1>#{@page.name}</h1>"
      end
    end
  end
end
