require 'spec_helper'

describe Snippet do
  it { should validate_presence_of(:data) }

  describe "Tagging" do
    it "should use a comma as a tag seperator" do
      snippet = Fabricate(:snippet)
      snippet.tags = "ruby, programming language"
      snippet.tags_array.count.should == 2
    end

  end
end
