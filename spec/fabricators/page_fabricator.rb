Fabricator(:page) do
  name { sequence(:name) {|i| "page#{i}" } }
end

Fabricator(:markdown_page, :from  => :page) do
  raw_data "#Title\n**bold** *italic*"
  markup  { Page::Markup::MARKDOWN }
end

Fabricator(:creole_page, :from  => :page) do
  raw_data "==Title\n**bold** //italic//"
  markup  { Page::Markup::CREOLE }
end
