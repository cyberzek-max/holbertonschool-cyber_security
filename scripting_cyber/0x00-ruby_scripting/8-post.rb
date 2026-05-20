require 'net/http'
require 'uri'
require 'json'

def post_request(url, body_params = {})
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == 'https')

  headers = { 'Content-Type' => 'application/json' }
  request = Net::HTTP::Post.new(uri.request_uri, headers)
  request.body = body_params.to_json

  response = http.request(request)

  puts "Response status: #{response.code} #{response.message}"
  puts "Response body:"
  puts response.body
end
