require 'spec_helper'

describe "offer/get.html.erb" do

  describe 'list offers' do
    before(:each) do
      @offers = double('offer')
      @offers.should_receive(:error?).and_return(false)
      @offers.should_receive(:empty?).and_return(false)
      @offers.should_receive(:list).and_return([{"title" => 'Title1', "payout" => 123, "thumbnail" => {"lowres" => 'http://example.com/image.jpg'}}])
      render
    end

    it "shows the offer items with title and payout information" do
      rendered.should have_xpath('//div[@class="offer"]/div[@class="title" and contains(text(), "Title1")]')
      rendered.should have_xpath('//div[@class="offer"]/div[@class="payout" and contains(text(), "123")]')
    end

    it "renders the thumbnail lowres image" do
      rendered.should have_xpath('//div[@class="offer"]/div[@class="thumbnail"]/img[@src="http://example.com/image.jpg"]')
    end

    it "shows the list of offers" do
      rendered.should have_xpath('//div[@class="offer"]')
    end

    it "shows a form to fill params of request" do
      rendered.should have_xpath('//form[@action="/offer/get"]/input[@type="submit"]')
    end
  end

  describe "empty offer list" do
    it "renders 'no offers' message when there is no offers in a list" do
      @offers = double('offer')
      @offers.should_receive(:error?).and_return(false)
      @offers.should_receive(:empty?).and_return(true)
      render
      rendered.should have_xpath('//div[@class="no-offers" and contains(text(), "No offers")]')
    end
  end

  describe 'error happened' do
    it "shows an error message when error occurred" do
      @offers = double('offer')
      @offers.should_receive(:error?).and_return(true)
      @offers.should_receive(:error_message).and_return('Error message')
      render
      rendered.should have_xpath('//div[@class="error-message" and contains(text(), "Error message")]')
    end
  end

end
