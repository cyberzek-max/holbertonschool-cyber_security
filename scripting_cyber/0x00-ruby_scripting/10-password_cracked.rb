#!/usr/bin/env ruby

require 'digest'

# Check arguments
if ARGV.length != 2
  puts "Usage: #{__FILE__} HASHED_PASSWORD DICTIONARY_FILE"
  exit 1
end

hashed_password = ARGV[0].downcase
dictionary_file = ARGV[1]

# Ensure file exists
unless File.exist?(dictionary_file)
  puts "Dictionary file not found: #{dictionary_file}"
  exit 1
end

# Perform dictionary attack
found = false

File.foreach(dictionary_file) do |line|
  word = line.strip
  hash = Digest::SHA256.hexdigest(word)
  if hash == hashed_password
    puts "Password found: #{word}"
    found = true
    break
  end
end

puts "Password not found in dictionary." unless found
