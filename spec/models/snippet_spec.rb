require 'spec_helper'

klass = Class.new do
  include Snippet
  label :source, :source_url
end

class BaseSnippet
  include Snippet
end

describe Snippet do
  it { BaseSnippet.should validate_presence_of(:data) }

  let (:snippet) { BaseSnippet.new }
  describe "Tagging" do
    it "should use a comma as a tag separator" do
      snippet.tags = "ruby, programming language"
      snippet.tags.count.should == 2
    end

  end

  describe ".set_label" do
    let (:snippet) { BaseSnippet.new }

    it "should strip whitespaces" do
      snippet.set_label("author", " Haruki Murakami " )
      snippet.labels["author"].should == "Haruki Murakami"
    end

    it "shold handle nil values" do
      snippet.set_label("author", nil)
      snippet.labels["author"].should be_nil
    end

  end

  describe "#label" do
    let(:instance) { klass.new }

    it "should generate accessors for the label" do
      instance.respond_to?(:source).should be_true
      instance.respond_to?(:source=).should be_true
    end

    it "should store the labels inside the labels field" do
      source = "source"
      instance.source = source
      instance.labels["source"].should == source
    end
  end
end
