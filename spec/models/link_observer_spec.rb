require 'spec_helper'

describe LinkObserver do


  it "should regenerate screenshots when url changes" do
    link = Fabricate(:link)
    link.url = "http://www.mixi.jp"
    ScreenshotGrabber.should_receive(:perform_async).with(link.id)
    LinkObserver.instance.before_save(link)
  end

  it "should not generate screenshots if the url didn't change" do
    link = Fabricate(:link)
    link.url = link.url.dup
    ScreenshotGrabber.should_receive(:perform_async).never
    LinkObserver.instance.before_save(link)
  end
end
