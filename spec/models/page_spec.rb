require 'spec_helper'

describe Page do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:markup) }
  it { should validate_presence_of(:raw_data) }
  it { should validate_uniqueness_of(:name) }

  describe ".supported_markups" do
    it "should return an array of all supported markups" do
      Page.supported_markups.count.should == Page::Markup.constants.count
    end
  end

  describe "Tagging" do
    it "should support tags with whitespaces" do
      page = Fabricate(:markdown_page)
      page.tags = "tokyo tower"
      page.tags_array.count.should == 1
      page.tags_array.first.should == "tokyo tower"
    end

    it "should use a comma as a tag seperator" do
      page = Fabricate(:markdown_page)
      page.tags = "tokyo tower, tokyo"
      page.tags_array.count.should == 2
    end

  end

  describe "Links" do
    context "page with external links" do
    end
  end
end
