require 'spec_helper'

describe ResourceAuthorizer do

  before :each do
    @owner = Fabricate.build(:user)
    @user = Fabricate.build(:user)
  end

  describe "private resources" do

    before :each do
      @page = Fabricate.build(:markdown_page, :author  => @owner, :private  => true)
      @bookmark = Fabricate.build(:bookmark, :creator  => @owner, :private  => true)
    end

    {:read  => :readable, :update  => :updatable, :delete  => :deletable}.each do |verb, ability|
      it "should not let users #{verb} the resource" do
        @page.authorizer.send("#{ability}_by?".to_sym, @user).should be_false
        @bookmark.authorizer.send("#{ability}_by?".to_sym, @user).should be_false
      end

      it "should let the resource's owner read the resource" do
        @page.authorizer.send("#{ability}_by?", @owner).should be_true
        @bookmark.authorizer.send("#{ability}_by?", @owner).should be_true
      end
    end
  end
end
