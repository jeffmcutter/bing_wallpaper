#!/usr/bin/env ruby

begin

  require 'pathname'
  NAME = Pathname.new($0).basename

  def usage
    puts "USAGE: #{NAME} dir1 [dir2..dirN]"
    exit 1
  end

  def lines_to_array(files)
    array = []
    files.each do |file_name|
      if File.exist?(file_name)
        File.readlines(file_name).each do |line|
          array.push(line)
        end
      else
        raise "File #{file_name} doesn't exist"
      end
    end
    return array
  end

  unless ARGV.count > 0
    usage
  end

  files_array = lines_to_array(ARGV)
  puts files_array.sample

rescue => err
  puts "#{NAME} error encountered: #{err}."
  exit 1
end
