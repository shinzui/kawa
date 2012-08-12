Fabricator(:bookmark) do
  url "http://mixi.jp"
  creator { Fabricate.build(:user) }
end
