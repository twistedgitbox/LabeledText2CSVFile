#! /usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require_relative './lib/LabelReader'

files = File.join(File.dirname(__FILE__),'..','lib','**','*.rb')
Dir.glob(files).each do |file|
  require file
end

class Label_Run

  def init_lize
    testbox = []
    checkfile = false
    checktemplate = false
    missingcheck = false
    @template_path = ""
    ARGV.each do|a|
    testbox << "#{a}"
    end
    if testbox.count < 2 then
      puts "Please run filename and labeltype following run command as in './script.rb filename labeltype'"
      abort
    end
    filename = testbox[0]
    option = testbox[1]
    checkfile = self.check_filename(filename)
    checktemplate = self.check_template(option)
    puts "checkfile #{checkfile}"
    puts "checktemplate #{checktemplate}"
    missingcheck = true if checkfile == true || checktemplate == true
    puts "missingcheck #{missingcheck}"
    if missingcheck == true
      template_path = @template_path
      puts "TEMPLATE PATH: #{template_path}"
      puts "FILENAME: #{filename}"
      puts "LABELTYPE: #{option}"
      @labelcheck = LabeltoLabelList.new
      label_info = @labelcheck.buildlist_run(filename, option, template_path)
      puts "Label Info is => #{label_info}"
      puts ; puts ; puts
      puts "Completed getting data from text file based on the labels added. Check Export folder for CSV #{filename}.csv."
    elsif
      puts "CANNOT RUN WITH MISSING FILES"
    end
  end

  def check_template(option)
    puts "CHECK_TEMPLATE ROUTINE"
    template_path = "./Label_Templates/"
    label_path = "#{template_path}#{option}"
    if File.file?(label_path) then
      puts "#{option} is found in the #{template_path} directory"
      checktemplate = true
      @template_path = label_path
      puts "template: #{@template_path}"
    elsif
      puts "#{option} template not found in #{template_path} directory"
      checktemplate = false
    end
    puts checktemplate
    return checktemplate
  end

  def check_filename(filename)
    puts "CHECK FILENAME ROUTINE"
    if File.file?(filename) then
      puts "#{filename} is present"
      checkfile = true
    elsif
      puts "#{filename} not found"
      checkfile = false
    end
    puts checkfile
    return checkfile
  end

end

companycheck = Label_Run.new
companyapi = companycheck.init_lize
puts companyapi


