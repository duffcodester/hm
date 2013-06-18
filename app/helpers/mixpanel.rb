require 'base64'
require 'json'
require 'net/http'

module Mixpanel
  TOKEN = 'b3e4bf7f8c8ef61e0ba0c80a21361071'

  ENDPOINT = 'http://api.mixpanel.com/track/'

  # A simple function for logging to the mixpanel.com API.
  #
  # event: The overall event/category you are tracking.
  #
  # properties: A hash of key-value pairs that describe the
  # event. Must include the Mixpanel API token as 'token'.
  #
  # See http://mixpanel.com/api/ for further detail.
  def self.track(event, properties={})
    if !properties.has_key?('token')
      raise 'Token is required'
    end

    params = { 'event' => event, 'properties' => properties}
    data = Base64.strict_encode64(JSON.generate(params))
    request = URI(ENDPOINT + "?data=#{data}")

    begin
      Net::HTTP.get(request)
    rescue SocketError
      puts 'WARN: No internet connection'
    end
  end

  def self.simple_track(event, properties={})
    properties['distinct_id'] ||= 'not signed in'
    properties['token'] = TOKEN

    self.track(event, properties)
  end
end