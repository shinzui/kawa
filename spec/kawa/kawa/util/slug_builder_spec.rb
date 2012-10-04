#encoding: utf-8

require 'spec_helper'

module Kawa::Util
  describe SlugBuilder do

    it "should not translate japanese characters" do
      string = "日本"
      SlugBuilder.generate(string).should == string
    end

    it "should lowercase characters" do
      string = "JAPAN"
      SlugBuilder.generate(string).should == "japan"
    end

    it "should remove whitespace" do
      string = "san francisco"
      SlugBuilder.generate(string).should == "san-francisco"
    end

  end
end
