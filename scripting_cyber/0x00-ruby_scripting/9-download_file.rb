#!/usr/bin/env ruby

require 'open-uri'
require 'uri'
require 'fileutils'

# Check for correct number of arguments
if ARGV.length != 2
  puts "Usage: #{__FILE__} URL LOCAL_FILE_PATH"
  exit 1
end

url = ARGV[0]
local_path = ARGV[1]

begin
  puts "Downloading file from #{url}..."
  URI.open(url) do |remote_file|
    FileUtils.mkdir_p(File.dirname(local_path))
    File.open(local_path, 'wb') do |file|
      file.write(remote_file.read)
    end
  end
  puts "File downloaded and saved to #{local_path}."
rescue OpenURI::HTTPError => e
  puts "HTTP Error: #{e.message}"
rescue URI::InvalidURIError => e
  puts "Invalid URL: #{e.message}"
rescue => e
  puts "An error occurred: #{e.message}"
end
