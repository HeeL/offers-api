require 'spec_helper'
require 'ostruct'

describe Offer do

  describe '#get' do
    let(:offers){Offer.new({})}

    it "checks for an empty response" do
      offers.parsed_response = {code: 'NO_CONTENT'}
      offers.empty?.should be_true
    end

    it "checks for a response with an error code" do
      offers.parsed_response = {code: 'ERROR_INVALID_CATEGORY'}
      offers.error?.should be_true
    end

    it "gives an empty list when there is no offers" do
      offers.parsed_response = {}
      offers.list.should == []
    end

    it "returns an array of offers" do
      offers.parsed_response = {offers: [1,2,3]}
      offers.list.size.should == 3
    end

    it "checks if the response signature has been generated properly" do
      offers.response = OpenStruct.new
      offers.stub(:parse_response)
      offers.parsed_response = {code: 'ok'}
      offers.response.body = 'response body'
      offers.stub(:signature).and_return(Digest::SHA1.hexdigest("#{offers.response.body}#{Offer::API_KEY}"))
      offers.send_request
      offers.error?.should be_false
    end

    it "checks for unauthorized request" do
      offers.stub(:parse_response)
      offers.stub(:signature).and_return('123')
      offers.response = OpenStruct.new
      offers.response.body = 'some text'
      offers.parsed_response = {}
      offers.send_request
      offers.error?.should be_true
      offers.error_message.should == 'Unauthorized request detected'
    end
  end

end