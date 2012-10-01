require 'spec_helper'

module Kawa::Wiki::Plugin
  describe Page do
    before :each do
      @pages = []
      3.times { @pages << Fabricate.build(:page)}
    end

    let(:page_plugin) { Page.new(@pages.first) }
    let(:tags) { "japan,nihon" }

    it "should return links to all pages matching the specified tags" do
      ::Page.stub(:tagged).with(tags.split(",")).and_return([@pages.second, @pages.third])
      result = page_plugin.process(:tags  => tags)
      result.should match(/#{@pages.second.name}/)
      result.should match(/#{@pages.third.name}/)
    end

    it "should not return the current page" do
      ::Page.stub(:tagged).with(tags.split(",")).and_return([@pages.first, @pages.second])
      result = page_plugin.process(:tags  => tags)
      result.should_not match(/#{@pages.first.name}/)
      result.should match(/#{@pages.second.name}/)
    end

  end
end
