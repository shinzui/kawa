require 'spec_helper'

describe Kawa::Markdown::HtmlRenderer do
  include Rails.application.routes.url_helpers

  before :each do
    @renderer = Redcarpet::Markdown.new(Kawa::Markdown::HtmlRenderer, :autolink  => true)
  end

  describe "Autolink" do
    it "Should replace the link by a short url" do
      html = @renderer.render("http://tnm.jp")
      doc = Nokogiri::HTML::DocumentFragment.parse(html)
      anchor = doc.at_css("a")
      anchor.text.should == "http://tnm.jp"
      link = Link.with_url("http://tnm.jp").first
      anchor["href"].should == link_path(link)
      anchor["title"].should == link.url 
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
        @anchor["href"].should == link_path(@link)
        @anchor["title"].should == @link.url
        @anchor.text.should == "Tokyo National Museum"
      end

      it "should have an external css class for external links" do
        @anchor["class"].should == "external"
      end
    end
  end
end
