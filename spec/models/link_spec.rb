require 'spec_helper'

describe Link do
  it { should validate_uniqueness_of(:data) }

  describe "Normalizing urls" do
    before :each do
      @link = Fabricate(:link, :url  => "http://www.tnm.jp//?utm_source=source&utm_content=content#extra")
    end

    it "should strip the utm* parameters" do
      @link.url.should == "http://www.tnm.jp/"
    end
  end

  describe "shorten url" do
    before :each do 
      @link = Fabricate(:link)
    end

    it "should have its id as a short url" do
      @link._id.should == "1"
    end
  end

  it_behaves_like "destroying links", Link

  describe "#generate_screenshot?" do
    it "should return true if the link does not have a screenshot" do
      @link  = Fabricate.build(:link)
      @link.generate_screenshot?.should == true
    end
  end

  describe "_id" do
    it "should use sequence and be stable" do
      @link = Fabricate(:link)
      @link._id.should == "1"
      @link.save
      @link.reload._id.should == "1"
    end
  end

  describe "#associate_to_page" do
    before :each do
      @page = Fabricate.build(:markdown_page, :author  => Fabricate.build(:user))
    end

    context "link associated to public page" do
      before :each do
        @page.private = true
        @link = Fabricate.build(:link)
        @link.pages = [Fabricate.build(:markdown_page)]
      end

      it "should not change the privacy of the link" do
        @link.associate_to_page(@page)
        @link.should_not be_private
      end
    end

    context "link not associated to any public pages" do
      before :each do
        @link = Fabricate.build(:link)
        @link.pages = [Fabricate.build(:markdown_page, :private  => true)]
      end

      it "should mark the link as private when associated to a private page" do
        @page.private = true
        @link.associate_to_page(@page)
        @link.should be_private
      end
    end

    context "link without creator" do
      before :each do
        @link = Fabricate.build(:link)
      end

      it "should set the creator to the page's author" do
        @link.associate_to_page(@page)
        @link.creator.should == @page.author
      end
    end

    context "link with creator" do
      before :each do
        @link_creator = Fabricate.build(:user)
        @link = Fabricate.build(:link, :creator  => @link_creator)
      end

      it "should not change the link's creator" do
        @link.associate_to_page(@page)
        @link.creator.should == @link_creator
      end
    end
  end

end
