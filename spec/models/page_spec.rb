require 'spec_helper'

describe Page do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:markup) }
  it { should validate_presence_of(:raw_data) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:author) }

  describe ".supported_markups" do
    it "should return an array of all supported markups" do
      Page.supported_markups.count.should == Page::Markup.constants.count
    end
  end

  describe "Tagging" do
    it "should support tags with whitespaces" do
      page = Fabricate(:markdown_page)
      page.tags = "tokyo tower"
      page.tags.count.should == 1
      page.tags.first.should == "tokyo tower"
    end

    it "should use a comma as a tag seperator" do
      page = Fabricate(:markdown_page)
      page.tags = "tokyo tower, tokyo"
      page.tags.count.should == 2
    end

  end

  describe "#title" do
    context "page without a headline on top" do
      context "markdown page" do
        it "should return the page name"  do
          page = Fabricate.build(:markdown_page, :raw_data => "[link](http://www.github.com)" )
          page.title.should == page.name
        end
      end
    end

    context "page with a header" do
      context "markdown page" do
        it "should return the page headline text" do
          page_title = "Title"
          page = Fabricate.build(:markdown_page,  :raw_data  => "\n\n##{page_title}")
          page.title.should == page_title
        end
      end

    end
  end

  describe "Backlinks" do
    before :each do
      page_data =<<-DATA
# Backlinks

[[Lee Da Hae]]

[[Kim So Yeon]]
      DATA
      @linked_page = Fabricate(:markdown_page, name: 'Kim So Yeon')
      @page = Fabricate(:markdown_page, :raw_data  => page_data)
    end

    context "to existing page" do
      it "should reference the outbound pages" do
        @page.outbound_page_links.where(inbound_page: @linked_page).count.should == 1
      end

      it "the outbound page should contain a reference to the inbound page" do
        @linked_page.inbound_page_links.where(outbound_page: @page).count.should == 1 
      end

      it "should remove the backlink if the link is removed" do
        @page.raw_data = "# No Backlinks\n [[Lee Da Hae]]"
        @page.save

        @linked_page.inbound_page_links.where(outbound_page: @page).count.should == 0
      end
    end

    context "to non-existing page" do
      it "should reference the outbound page by its name" do
        @page.outbound_page_links.where(inbound_page_name: 'Lee Da Hae').count.should == 1
      end

      it "should remove the backlink if the page is removed" do
        Backlink.where(inbound_page_name: 'Lee Da Hae').count.should == 1
        @page.raw_data = "# No Backlinks\n [[Kim So Yeon]]"
        @page.save

        Backlink.where(inbound_page_name: 'Lee Da Hae').count.should == 0
      end
    end

    context "updating dead backlinks" do
      
      it "should update the backlinks to link to the new page" do
        backlink = Backlink.where(inbound_page_name: 'Lee Da Hae').first
        backlink.should be_present

        lee_da_hae = Fabricate(:markdown_page, name: 'Lee Da Hae')

        backlink.reload.inbound_page_name.should be_nil
        backlink.inbound_page.should == lee_da_hae
      end

      it "should update backlinks to deleted pages" do
        backlink = Backlink.where(outbound_page_id: @page.id, inbound_page_id: @linked_page.id).first
        backlink.should be_present

        @linked_page.destroy

        backlink.reload.inbound_page.should be_nil
        backlink.inbound_page_name.should == 'Kim So Yeon'
      end
    end
  end

  describe "Links" do
    context "page with external links" do
      before :each do
        page_data =<<-EOS
# Tokyo Museum and Art Galleries

[Tokyo National Museum](http://tnm.jp)

[Edo Tokyo Museum](http://www.edo-tokyo-museum.or.jp)

[Tokyo Art Beat](http://www.tokyoartbeat.com/?utm_source=source&utm_content=content#t)
        EOS
        @page = Fabricate(:markdown_page, :raw_data  => page_data)
      end

      it "should create references to the links" do
        @page.links.count.should == 3
        @page.links.each do |link|
          link.pages.should include(@page)
        end
      end

      context "handling internal links" do
        it "should not create a link" do
          expect {
            @page.update_attributes(raw_data: " [[Internal link]]")
          }.to_not change { Link.count }
          @page.should have(0).links
        end
      end

      context "removing all links" do
        it "should remove all link references" do
          @page.update_attributes(raw_data: "# Links")
          @page.reload.should have(0).links
        end
      end

      context "removing a link" do
        before :each do
          new_data =<<-EOS
[Edo Tokyo Museum](http://www.edo-tokyo-museum.or.jp)
          EOS
          @page.raw_data = new_data
          @page.save
        end

        it "should update references to the links" do
          @page.links.count.should == 1
          @page.links.first.url.should == "http://www.edo-tokyo-museum.or.jp/"
          link = Link.with_url("http://tnm.jp/").first
          link.pages.should_not include(@page)
        end
      end
    end
  end
end
