#!/usr/bin/env ruby
require 'optparse'

FILE_NAME = 'tasks.txt'

options = {}
opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: cli.rb [options]"

  opts.on("-a", "--add TASK", "Add a new task") do |task|
    options[:add] = task
  end

  opts.on("-l", "--list", "List all tasks") do
    options[:list] = true
  end

  opts.on("-r", "--remove INDEX", "Remove a task by index") do |index|
    options[:remove] = index.to_i
  end

  opts.on("-h", "--help", "Show help") do
    puts opts
    exit
  end
end

opt_parser.parse!

if options[:add]
  task = options[:add]
  File.open(FILE_NAME, 'a') do |f|
    f.puts(task)
  end
  puts "Task '#{task}' added."

elsif options[:list]
  if File.exist?(FILE_NAME) && !File.zero?(FILE_NAME)
    puts "Tasks:"
    File.readlines(FILE_NAME).each_with_index do |line, index|
      puts "#{index + 1}. #{line.strip}"
    end
  end

elsif options[:remove]
  index_to_remove = options[:remove]
  if File.exist?(FILE_NAME)
    lines = File.readlines(FILE_NAME)
    if index_to_remove > 0 && index_to_remove <= lines.length
      removed_task = lines.delete_at(index_to_remove - 1).strip
      File.open(FILE_NAME, 'w') do |f|
        f.puts(lines)
      end
      puts "Task '#{removed_task}' removed."
    end
  end
end
