require 'httparty'

class OfferController < ApplicationController

  def get
    @offers = Offer.new(params)
    @offers.send_request
  end

end