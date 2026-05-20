#!/usr/bin/env ruby

require 'optparse'
require 'fileutils'

TASKS_FILE = 'tasks.txt'

# Ensure tasks file exists
def ensure_tasks_file
  FileUtils.touch(TASKS_FILE) unless File.exist?(TASKS_FILE)
end

# Read tasks from file
def read_tasks
  ensure_tasks_file
  File.readlines(TASKS_FILE).map(&:chomp)
end

# Write tasks to file
def write_tasks(tasks)
  File.open(TASKS_FILE, 'w') do |file|
    tasks.each { |task| file.puts task }
  end
end

# Add a new task
def add_task(task)
  tasks = read_tasks
  tasks << task
  write_tasks(tasks)
  puts "Task '#{task}' added."
end

# List all tasks
def list_tasks
  tasks = read_tasks
  if tasks.empty?
    puts 'No tasks found.'
  else
    puts 'Tasks:'
    tasks.each do |task|
      puts task
    end
  end
end

# Remove a task by index
def remove_task(index)
  tasks = read_tasks
  if index.between?(1, tasks.length)
    removed_task = tasks.delete_at(index - 1)
    write_tasks(tasks)
    puts "Task '#{removed_task}' removed."
  else
    puts "Error: Invalid task index."
  end
end

# Parse command-line options
options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: cli.rb [options]'
  
  opts.on('-a', '--add TASK', 'Add a new task') do |task|
    options[:add] = task
  end
  
  opts.on('-l', '--list', 'List all tasks') do
    options[:list] = true
  end
  
  opts.on('-r', '--remove INDEX', Integer, 'Remove a task by index') do |index|
    options[:remove] = index
  end
  
  opts.on('-h', '--help', 'Show help') do
    puts opts
    exit
  end
end.parse!

# Execute based on options
if options.empty?
  puts 'Usage: cli.rb [options]'
  puts 'Try ./11-cli.rb -h for more information.'
  exit 1
end

if options[:add]
  add_task(options[:add])
elsif options[:list]
  list_tasks
elsif options[:remove]
  remove_task(options[:remove])
end
