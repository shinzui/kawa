require 'spec_helper'

shared_examples "destroying links" do |link_klass|
  it "should not allow deleling pages that are still references on pages" do 
    link = Fabricate(link_klass.to_s.underscore.to_sym)
    link.pages = [Fabricate(:markdown_page)]
    link.save
    link.destroy
    link.should_not be_destroyed
  end
end

