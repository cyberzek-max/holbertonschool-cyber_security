#!/usr/bin/env ruby
require 'net/http'
require 'json'
require 'uri'

def get_request(url)
  uri = URI(url)
  reponse = Net::HTTP.get_response(uri)

    status_code = reponse.code
    status_message = reponse.message
    response_body = JSON.parse(reponse.body)

    puts "Response status: #{status_code} #{status_message}"
    puts "Response body:"
    puts JSON.pretty_generate(response_body)
  
end
