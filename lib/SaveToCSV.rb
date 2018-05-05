#! /usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'csv'

#require_relative 'api_check'
#require_relative 'label_reader'
#require_relative 'FC_json_reader'
#require_relative 'CB_json_reader'

class Data_Converter

 def initialize
  puts "INIT JSON CHECK"
  ## TRACK METHODS ##
  puts "CALLING METHOD: #{caller[0] =~ /`([^']*)'/ and $1}"
  puts "CURRENT METHOD: #{__method__.to_s}"
  ## PUT IN CODE TO TRACK METHOD CALLS
  #self.check_for_API_key
  #puts "YOUR KEY IS #{@api_key}"
  @org_info = {}
  @all_orgs = []
  @listings = []
 end

 def init_lize(filename)
  puts "START JSON CHECK"
  ## TRACK METHODS ##
  puts "CALLING METHOD: #{caller[0] =~ /`([^']*)'/ and $1}"
  puts "CURRENT METHOD: #{__method__.to_s}"
  ## PUT IN CODE TO TRACK METHOD CALLS
  puts; puts; puts
  #filename.sub!(/^.\/read\//,'')
  filepath = "./export/#{filename}"
  @datafile = "#{filepath}.csv"
  puts "#### TRUNCATE FILES #{filename}"
  if File.exist?("#{filepath}_.csv") then
 File.truncate("#{filepath}_.csv", 0)
  end
  if File.exist?("#{filepath}.csv") then
 File.truncate("#{filepath}.csv", 0)
  end
 end

 def convert_DATA_to_CSV(newlist)
  ## TRACK METHODS ##
  puts "CALLING METHOD: #{caller[0] =~ /`([^']*)'/ and $1}"
  puts "CURRENT METHOD: #{__method__.to_s}"
  ## PUT IN CODE TO TRACK METHOD CALLS
  datafile = @datafile
  #datafile.sub!(/^.\/read\//,'')
  #datafile = "./export/CSV/#{@datafile}.csv"
  puts "FILE LOCATION: #{datafile}"
  #CSV.open(datafile, "a") {|csv| info_hash.to_a.each {|elem| csv << elem} }
  #CSV.open(datafile, 'wb') do |csv|
    #  csv << info_hash.keys
    #  puts info_hash.keys
    #  puts info_hash.values
    #  max_len = info_hash.values.map(&:length).max
    #  (0...max_len).zip(*info_hash.values).each do |_, *row|
    #    csv << row
    #  end
  #end
  @records = newlist
  puts "THESE RECORDS ARE #{@records}"
  ##newlist.each do |info_hash|
  ##  puts info_hash.class
  ##  unless info_hash.empty? || info_hash.nil?
  ##    CSV.open(datafile, "a", headers: info_hash.keys) do |csv|
  ##      #csv << ['URL', 'COMPANY', 'DESC', 'KEYWDS', 'PHONE']
  ##      puts info_hash.keys
  ##      csv << info_hash.values
  ##    end
  ##  end
  ##end
  headers = newlist.inject([]) {|res, h| h.keys | res}
  #all possible headers
  ##=> ["make", "model", "price"]

  rows = newlist.map {|h| h.values_at(*headers)}
  #=> [["nissan", "altima", nil], ["nissan", "maxima", "20,000"]]
  #CSV.generate do |csv|
  CSV.open(datafile, "a", headers: headers ) do |csv|
    csv << headers
    rows.each do |row|
      csv << row
    end
  end
  #abort
 #  info_hash.each do |hash|
 # csv << hash.values
 #  end
 #  end
 end

end

