Fabricator(:bookmark) do
  url { sequence(:url) { |i| "http://www#{i}.mixi.jp" }}
  creator { Fabricate.build(:user) }
end
