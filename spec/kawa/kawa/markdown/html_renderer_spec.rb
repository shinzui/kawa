require 'spec_helper'

describe Kawa::Markdown::HtmlRenderer do
  include Rails.application.routes.url_helpers

  before :each do
    @options = {:no_intra_emphasis  => true, :tables  => true, :autolink  => true}
    @renderer = Redcarpet::Markdown.new(Kawa::Markdown::HtmlRenderer.new(@options), @options)
  end

  describe "Autolink" do
    it "Should replace the link by a short url" do
      html = @renderer.render("http://tnm.jp")
      doc = Nokogiri::HTML::DocumentFragment.parse(html)
      anchor = doc.at_css("a")
      anchor.text.should == "http://tnm.jp"
      link = Link.with_url("http://tnm.jp").first
      anchor["href"].should == short_url_path(link)
      anchor["title"].should == link.url 
    end

  end

  describe "Table rendering" do
    before :each do
      @page =<<-TABLE
        Header1 | Header2 
        ------- | -------
        Cell1   | Cell2
      TABLE
    end

    context "with table_css_class config" do
      before :each do
        @css_class = "table table-striped table-bordered table-condensed"
        options = @options.merge(:table_css_class  => @css_class)
        @renderer = Redcarpet::Markdown.new(Kawa::Markdown::HtmlRenderer.new(options),options)
        @html = @renderer.render(@page)
        @doc = Nokogiri::HTML::DocumentFragment.parse(@html)
        @table = @doc.at_css("table")
      end

      it "should render the table with the configured css classes" do
        @table["class"].should == @css_class
      end
    end

    context "without table_css_class config" do
      before :each do
        @html = @renderer.render(@page)
        @doc = Nokogiri::HTML::DocumentFragment.parse(@html)
        @table = @doc.at_css("table")
      end

      it "should render a table without any css classes" do
        @table["class"].should be_nil
      end

      it "should surround the header with thead" do
        @table.first_element_child.name.should == "thead"
      end

      it "should render the table header" do
        tr = @table.first_element_child.first_element_child
        tr.name.should == "tr"
        tr.search(">th").map(&:text).should == ["Header1", "Header2"]
      end

      it "should render the table body" do
        tr = @table.last_element_child.first_element_child
        tr.name.should == "tr"
        tr.search(">td").map(&:text).should == ["Cell1", "Cell2"]
      end

      it "should surround the body with tbody" do
        @table.last_element_child.name.should == "tbody"
      end
    end

  end

  describe "Link rendering" do

    context "with existing matching link" do
      before :each do
        @link = Fabricate(:link)
      end

      it "should not create a new link" do
        expect {
          @renderer.render("[Tokyo National Museum](#{@link.url})")
        }.to_not change { Link.count }
      end
    end

    context "external link" do
      before :each do
        html = @renderer.render("[Tokyo National Museum](http://tnm.jp)")
        @link = Link.with_url("http://tnm.jp").first
        doc = Nokogiri::HTML::DocumentFragment.parse(html)
        @anchor = doc.at_css("a")
      end

      it "should link to a kawa link and place original link in title" do
        @anchor["href"].should == short_url_path(@link)
        @anchor["title"].should == @link.url
        @anchor.text.should == "Tokyo National Museum"
      end

      it "should have an external css class for external links" do
        @anchor["class"].should == "external"
      end

      it "should store the link id in a data attribute" do
        @anchor["data-id"].should == @link.id
      end
    end
  end
end
