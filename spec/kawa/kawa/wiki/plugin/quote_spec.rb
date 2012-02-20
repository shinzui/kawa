require 'spec_helper'

describe Kawa::Wiki::Plugin::Quote do

  before :each do
    @quote = Fabricate.build(:quote)
    ::Quote.stub(:random).and_return(@quote)
    ApplicationController.new.set_current_view_context       
  end

  it "should render a random quote" do
    Kawa::Wiki::Plugin::Quote.new(Fabricate.build(:page)).process.should match(/#{@quote.data}/)
  end
end
