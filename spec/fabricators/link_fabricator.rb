Fabricator(:link) do
  url "http://mixi.jp"
  creator { Fabricate.build(:user) }
end

Fabricator(:link_with_screenshot, :from  => :link) do
  url_screenshot { open("#{Rails.root}/spec/fixtures/mixi.jpg") }
end
