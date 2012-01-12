module PagesHelper
  def render_comma(array, index)
    "," if index < (array.size - 1)
  end
end
