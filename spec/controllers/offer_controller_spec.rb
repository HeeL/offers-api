require 'spec_helper'

describe OfferController do
  describe "#get" do
    let(:offers) do
       offers = double('Offer')
       Offer.stub(:new).and_return(offers)
       offers
     end

     it "sends a request" do
       offers.should_receive(:send_request)
       post :get
     end
  end

  describe "#index" do
    it "renders index template" do
      get :index
      response.should render_template("offer/index")
    end
  end

end
