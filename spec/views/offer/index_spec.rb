require 'spec_helper'

describe "offer/index.html.erb" do
  before(:each) do
    render
  end

  it "asks to fill the form with request params" do
    rendered.should have_xpath('//form[@action="/offer/get"]/input[@name="uid"]')
    rendered.should have_xpath('//form[@action="/offer/get"]/input[@name="pub0"]')
    rendered.should have_xpath('//form[@action="/offer/get"]/input[@name="page"]')
  end

  it "doesn't show offers" do
    rendered.should_not have_xpath('//div[@class="offer"]')
  end

end
