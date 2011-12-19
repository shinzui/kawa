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
end
