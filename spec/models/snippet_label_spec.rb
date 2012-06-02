require 'spec_helper'

TestKlass = Class.new do
  include Mongoid::Document
  include SnippetLabel
end

AnotherTestKlass = Class.new do
  include Mongoid::Document
  include SnippetLabel
end

describe SnippetLabel do
  before :each do
    @object = TestKlass.new
  end


  describe ".label" do

    it "should remember declared labels" do
      TestKlass.label :one, :two
      TestKlass.label :three
      TestKlass.declared_labels.should == [:one, :two, :three]
      AnotherTestKlass.declared_labels.should be_empty
    end

    it "should define accessors for the label" do
      TestKlass.public_method_defined?(:lang).should be_false
      TestKlass.public_method_defined?(:lang=).should be_false

      TestKlass.label :lang

      TestKlass.public_method_defined?(:lang).should be_true
      TestKlass.public_method_defined?(:lang=).should be_true
    end

  end
  

end
