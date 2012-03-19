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

  describe "_id" do
    it "should use sequence and be stable" do
      @link = Fabricate(:link)
      @link._id.should == "1"
      @link.save
      @link.reload._id.should == "1"
    end
  end

end
