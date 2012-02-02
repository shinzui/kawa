module ApplicationHelper
  def on_path?(path)
    request.env['PATH_INFO'] =~ /^\/#{path}/i
  end
end
