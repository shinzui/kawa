Fabricator(:page) do
  name { sequence(:name) {|i| "page#{i}" } }
  author { Fabricate(:user)}
end

Fabricator(:markdown_page, :from  => :page) do
  raw_data "##Title\n**bold** *italic*"
  markup  { Page::Markup::MARKDOWN }
end

Fabricator(:markdown_page_with_links, :from  => :markdown_page) do
  raw_data <<-PAGE_DATA
##Title
**bold** *italic*
[cookpad](http://www.cookpad.com)
  PAGE_DATA
end

Fabricator(:creole_page, :from  => :page) do
  raw_data "==Title\n**bold** //italic//"
  markup  { Page::Markup::CREOLE }
end
