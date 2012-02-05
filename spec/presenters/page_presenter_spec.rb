require 'spec_helper'

describe PagePresenter do

  before :each do
    ApplicationController.new.set_current_view_context       
  end

  let(:presenter) { PagePresenter.new(@page) }

  describe ".header" do
    context "page without headline" do

      before :each do
        @page = Fabricate.build(:markdown_page, :raw_data  => "### Test") 
      end

      it "should return the page name" do
        presenter.header.should == "<header><h1>#{@page.name}</h1></header>"
      end
    end

    context "page with headline" do
      before :each do
        @page = Fabricate.build(:markdown_page, :raw_data  => "\n#Title\nBody")
      end

      it "should return the embedded title" do
        presenter.header.should == "<header><h1>Title</h1></header>"
      end
    end

  end

  describe ".data" do
    context "page with headline" do
      before :each do 
        @body = "Page Body"
        @page = Fabricate.build(:markdown_page, :raw_data  => "\n\n# Title\n#{@body}")
      end

      it "should strip the headline" do
        presenter.data.should == MarkupRenderer.renderer(:markdown)[@body]
      end
    end

    context "page without headline" do
      before :each do 
        @data = "\n##Title\nBody" 
        @page = Fabricate.build(:markdown_page, :raw_data  => @data)
      end

      it "should render the data" do
        presenter.data.should == MarkupRenderer.renderer(:markdown)[@data]
      end
    end
  end
end
