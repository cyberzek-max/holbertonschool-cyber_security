#!/usr/bin/env ruby

require 'optparse'

TASKS_FILE = 'tasks.txt'

# Ensure tasks.txt exists
File.write(TASKS_FILE, '') unless File.exist?(TASKS_FILE)

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: cli.rb [options]"

  opts.on("-a", "--add TASK", "Add a new task") do |task|
    options[:add] = task
  end

  opts.on("-l", "--list", "List all tasks") do
    options[:list] = true
  end

  opts.on("-r", "--remove INDEX", Integer, "Remove a task by index") do |index|
    options[:remove] = index
  end

  opts.on("-h", "--help", "Show help") do
    puts opts
    exit
  end
end.parse!

# Handle options
if options[:add]
  File.open(TASKS_FILE, 'a') { |f| f.puts(options[:add]) }
  puts "Task '#{options[:add]}' added."

elsif options[:list]
  tasks = File.readlines(TASKS_FILE, chomp: true)
  if tasks.empty?
    puts "No tasks found."
  else
    tasks.each_with_index do |task, i|
      puts "#{i + 1}. #{task}"
    end
  end

elsif options[:remove]
  index = options[:remove] - 1
  tasks = File.readlines(TASKS_FILE, chomp: true)
  if index.between?(0, tasks.length - 1)
    removed = tasks.delete_at(index)
    File.write(TASKS_FILE, tasks.join("\n") + "\n")
    puts "Task '#{removed}' removed."
  else
    puts "Invalid index. Use -l to list tasks."
  end

else
  puts "Use -h for help."
end
