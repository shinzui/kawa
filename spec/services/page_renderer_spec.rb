require 'spec_helper'

describe PageRenderer do
  include Rails.application.routes.url_helpers

  describe "Renderer the same page" do
    before :each do
      @page = Fabricate.build(:markdown_page, :raw_data  => "#Title\n[[Page Link]]")
      @first_renderer = PageRenderer.new(@page)
      @second_renderer = PageRenderer.new(@page)
    end

    context "with different renderer instances" do
      it "should return the same result" do
        @first_renderer.render.should == @second_renderer.render
      end
    end
  end

  describe "Markdown page rendering" do
    before :each do
      @page = Fabricate.build(:markdown_page, :raw_data  => "#Title")
      @renderer = PageRenderer.new(@page)
    end

    it "should convert the page markkup" do
      @renderer.render.should match("<h1>Title</h1>")
    end
  end

  describe "Interwiki links" do

    let(:page) { Fabricate.build(:markdown_page, :raw_data  => "#Title\n#{@interwiki_link}") }
    let(:renderer) { PageRenderer.new(page) }

    context "Page name links to existing pages" do
      before :each do
        @linked_page = Fabricate(:markdown_page, :name  => "Tokyo tower")
      end

      it "should create link with class present" do
        @interwiki_link = "[[#{@linked_page.name}]]"
        expected_link = "<a class=\"present\" href=\"#{page_path(@linked_page)}\">#{@linked_page.name}</a>"
        renderer.render.should match expected_link
      end

      it "should support case-insensitive names" do
        @interwiki_link = "[[#{@linked_page.name.upcase}]]"
        expected_link = "<a class=\"present\" href=\"#{page_path(@linked_page)}\">#{@linked_page.name.upcase}</a>"
        renderer.render.should match expected_link
      end

    end

    context "Page name links to non-existing pages" do
      before :each do
        @linked_page = Fabricate.build(:markdown_page, :name  => "Roppongi")
        @interwiki_link = "[[#{@linked_page.name}]]"
      end

      it "should create link with class absent" do
        expected_link = "<a class=\"absent\" href=\"#{new_page_path(page: {name: @linked_page.name})}\">#{@linked_page.name}</a>" 
        renderer.render.should match Regexp.escape(expected_link)
      end
    end

    context "Page name links with title" do
      before :each do
        @linked_page = Fabricate.build(:markdown_page, :name  => "Roppongi")
        @title = "Roppongi Hills"
        @interwiki_link = "[[#{@title}|#{@linked_page.name}]]"
      end

      it "should create a link with the specified title" do
        expected_link =  "<a class=\"absent\" href=\"#{new_page_path(page: {name: @linked_page.name})}\">#{@title}</a>"
        renderer.render.should match Regexp.escape(expected_link)
      end
    end

  end


end