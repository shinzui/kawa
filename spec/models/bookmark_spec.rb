require 'spec_helper'

describe Bookmark do
  it_behaves_like "destroying links", Bookmark
end
