class Offer
  attr_accessor :response, :parsed_response
  include HTTParty

  API_URL = 'http://api.sponsorpay.com/feed/v1/offers.json'
  API_KEY = 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'

  def initialize(params)
    @request_params = {
      page: params[:page],
      pub0: params[:pub0],
      uid: params[:uid],
      timestamp: Time.now.to_i,
      appid: 157,
      device_id: "2b6f0cc904d137be2e1730235f5664094b831186",
      locale: "de",
      ip: "109.235.143.113",
      offer_types: 112
    }
  end

  def send_request
    generate_hash
    parse_response
    check_signature
  end

  def list
    @parsed_response[:offers] ? @parsed_response[:offers] : []
  end

  def empty?
    @parsed_response[:code] == 'NO_CONTENT'
  end

  def error?
    @parsed_response[:code].include? 'ERROR'
  end

  def error_message
    @parsed_response[:message]
  end

  private
  def parse_response
    @response = self.class.get(API_URL, query: @request_params)
    @parsed_response = @response.parsed_response.deep_symbolize_keys
  end

  def check_signature
    set_error('ERROR_BAD_SIGNATURE', 'Unauthorized request detected') if signature && !valid_signature?
  end

  def set_error(code, msg)
    @parsed_response[:code] = code
    @parsed_response[:message] = msg
  end

  def sha1(string)
    Digest::SHA1.hexdigest string
  end

  def generate_hash
    @request_params[:hashkey] = sha1 "#{Hash[@request_params.sort].to_param}&#{API_KEY}"
  end

  def signature
    @response.headers['x-sponsorpay-response-signature']
  end

  def valid_signature?
    signature == sha1("#{@response.body}#{API_KEY}")
  end

end