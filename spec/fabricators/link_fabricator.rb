Fabricator(:link) do
  url "http://mixi.jp"
  creator { Fabricate.build(:user) }
end
