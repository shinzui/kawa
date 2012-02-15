require 'spec_helper'

module Kawa::Wiki::Plugin
  describe WikiStat do
    let(:stat_plugin) { WikiStat.new(Fabricate.build(:markdown_page)) }


    it "should output the wiki stats" do
      page_count = 13
      Page.stub(:count).and_return(page_count)
      page_tag_count = 15
      Page.stub_chain(:tags, :count).and_return(page_tag_count)
      quote_count = 9
      Quote.stub(:count).and_return(quote_count)
      quote_tag_count = 11
      Quote.stub_chain(:tags, :count).and_return(quote_tag_count)
      bookmark_count = 11
      Bookmark.stub(:count).and_return(bookmark_count)
      bookmark_tag_count = 7
      Bookmark.stub_chain(:tags, :count).and_return(bookmark_tag_count)
      link_count = 99
      Link.stub(:count).and_return(link_count)

      result = stat_plugin.process
      result.should match /#{page_tag_count} tags/
      result.should match /#{page_count} pages/
      result.should match /#{quote_count} quotes/
      result.should match /#{quote_tag_count} tags/
      result.should match /#{bookmark_count} bookmarks/
      result.should match /#{bookmark_tag_count} tags/
      result.should match /#{link_count} links/
    end

  end
end


