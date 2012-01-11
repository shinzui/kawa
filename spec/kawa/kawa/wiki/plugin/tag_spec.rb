require 'spec_helper'

module Kawa
  module Wiki
    module Plugin
      describe Tag do
        let(:tag_plugin) { Tag.new(@page) }

        before :each do
          @page = Fabricate.build(:markdown_page)
        end

        context "with tag values" do
          it "should associate the pages with the defined tags" do
            tag_plugin.process({:values  => "tokyo tower, tokyo"})
            @page.tags_array.size.should == 2 
          end
        end
       
        context "with missing tag values" do
          it "should raise an exception" do
            expect {tag_plugin.process({})}.to raise_error(MissingArgument)
          end
        end
      end
    end
  end
end
