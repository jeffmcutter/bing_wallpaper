#!/usr/bin/env ruby

begin

  require 'pathname'
  NAME = Pathname.new($0).basename

  def usage
    puts "USAGE: #{NAME} dir1 [dir2..dirN]"
    exit 1
  end

  def dir_files_to_array(directories)
    files = []
    directories.each do |dir|
      if File::directory?(dir)
        Dir.glob("#{dir}/*.jpg") do |file|
          files.push(file)
        end
      else
        raise "dir doesn't exist"
      end
    end
    return files
  end

  unless ARGV.count > 0
    usage
  end

  files_array = dir_files_to_array(ARGV)
  puts files_array.sample

rescue => err
  puts "#{NAME} error encountered: #{err}."
  exit 1
end
