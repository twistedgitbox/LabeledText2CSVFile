require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require_relative './lib/IndentLabel'

files = File.join(File.dirname(__FILE__),'..','lib','**','*.rb')
Dir.glob(files).each do |file|
  require file
end

class Label_Run

  def init_lize
    testbox = []
    ARGV.each do|a|
    testbox << "#{a}"
    end
    if testbox.count < 2 then
      puts "Please run filename and labeltype following run command as in './script.rb filename labeltype'"
      abort
    end
    filename = testbox[0]
    option = testbox[1]
    puts "FILENAME: #{filename}"
    puts "LABELTYPE: #{option}"
    @labelcheck = LabeltoLabelList.new
    label_info = @labelcheck.buildlist_run(filename, option)
    puts "Label Info is => #{label_info}"
    puts ; puts ; puts
  end
end

companycheck = Label_Run.new
companyapi = companycheck.init_lize
puts companyapi
