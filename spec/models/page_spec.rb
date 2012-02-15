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
