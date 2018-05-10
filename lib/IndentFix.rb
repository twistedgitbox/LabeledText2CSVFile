#! /usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

class Label_Fix

  def read_text_file(filename)
    file_array = File.readlines(filename)
    puts file_array.count
    puts file_array
    #filetext = self.split_text_by_labels(file_array)
    filetext = self.first_split(file_array)
    puts filetext
  end

  def first_split(file_array)
    @all_lines = []
    file_array.each do |line|

      unless line.nil? || line == 0
        puts line
        label_arr = line.scan(/[A-Z ]+:/)
        puts "LABEL COUNT #{label_arr.count}"
        line_arr = line.split(/[A-Z ]+:/)
        puts "COUNT #{line_arr.count}"
        puts line_arr

        line_arr.each_with_index do |textpart, index|
          puts; puts
          unless label_arr.count < (index)
            unless textpart.nil? || textpart.length <= 1
              fulltext = "#{label_arr[index-1]} #{textpart}"
              puts  "#{label_arr[index-1]} |  #{textpart}"
              textpart = fulltext
            end
          end
        @all_lines << textpart
      end

      end
    end
    puts "RETURN"
    @all_lines.join("\n")
    all_lines = @all_lines
    return all_lines
  end

  def save_fixedfile(filename, all_lines)
    puts ; puts ; puts
    puts "SAVING #{all_lines}"
    filepath = "#{filename}_fix"
    File.open(filepath, "w+") do |f|
      f.puts(all_lines)
    end
  end

  def array_cleaner(all_lines)
    all_lines.compact!
    all_lines.each do | line |
      line.strip! unless line.nil?
      line.chomp! unless line.nil?
      line.nil? ? nil : line.chomp!(",")
      line = "#{line}\n"
    end
    all_lines.map! { |word| "#{word}\n" }
    return all_lines
  end

  def run_labelfix(filename, option)
    all_lines = self.read_text_file(filename)
    rawlines = @all_lines
    all_lines = self.array_cleaner(rawlines)
    puts "#{all_lines}"
    self.save_fixedfile(filename, all_lines)
    puts "DONE"
    puts option
  end

end

#labelfixer = Label_Fix.new

#labelfixer.read_text_file("StartList")
