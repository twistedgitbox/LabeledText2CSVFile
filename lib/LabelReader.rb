#! /usr/bin/env ruby

require_relative 'SaveToCSV'

class LabeltoLabelList

  def init_lize(filename)
    File.open("./export/#{filename}.csv", "w") {}
    @list = ""
    self.get_list_name(filename)
  end

  def initialize
    @labels = []
    @records = []
    @template_path = ""
    @converter = Data_Converter.new
  end

  def get_list_name(filename)
    @listname = filename
  end

  def get_labels_person
    labels = []
    labels << "NAME"
    labels << "TITLE"
    labels << "COMPANY"
    labels << "BIO"
    labels << "EMAIL"
    labels << "PHONE"
    labels << "CATEGORY"

    puts labels
    return labels
  end

  def get_labels_speakers
    labels = []
    labels << "NAME"
    labels << "TITLE"
    labels << "COMPANY"
    labels << "BIO"
    labels << "EMAIL"
    labels << "PHONE"
    labels << "CATEGORY"
    labels << "TOPIC"

    puts labels
    return labels
  end

  def get_labels_website_short
    labels = []
    labels << "WEBSITE"
    labels << "COMPANY"
    labels << "CATEGORY"

    puts labels
    return labels
  end

  def get_labels_website_med
    labels = []
    labels << "WEBSITE"
    labels << "COMPANY"
    labels << "CATEGORY"
    labels << "DESC"

    puts labels
    return labels
  end

  def get_labels_company
    labels = []
    labels << "COMPANY"
    labels << "WEBSITE"
    labels << "ADDRESS"
    labels << "PHONE"
    labels << "DESC"
    puts labels
    return labels
  end

  def get_labels_company_full
    labels = []
    labels << "COMPANY"
    labels << "WEBSITE"
    labels << "PHONE"
    labels << "ADDRESS"
    labels << "DESC"
    labels << "CATEGORY"
    labels << "NOTES"
    labels << "CITY"
    labels << "STATE"
    labels << "ZIP"
    labels << "EMAIL"

    puts labels
    return labels
  end

  def get_labels_companies_full
    labels = []
    labels << "COMPANY"
    labels << "WEBSITE"
    labels << "PHONE"
    labels << "ADDRESS"
    labels << "DESC"
    labels << "NOTES"
    labels << "CITY"
    labels << "STATE"
    labels << "ZIP"
    labels << "EMAIL"

    puts labels
    return labels
  end

  def create_title_hash(option)
    labelsize = []
    label_hash = {}
    #line = "TITLE: RESULT OF NAME: DOG COMPANY:"
    puts @template_path
    template_path = @template_path
    #if template_path == "" then
    #case option
    #when "people"
    #  labels = self.get_labels_person
    #when "person"
    #  labels = self.get_labels_person
    #when "speaker", "speakers"
    #  labels = self.get_labels_speakers
    #when "companies"
    #  labels = self.get_labels_company
    #when "company"
    #  labels = self.get_labels_company
    #when "company_full"
    #  labels = self.get_labels_company_full
    #when "companies_full"
    #  labels = self.get_labels_companies_full
    #when "websites_short"
    #  labels = self.get_labels_website_short
    #when "websites_med"
    #  labels = self.get_labels_website_med
    #else
    #  puts "Not a valid labels set"
    #  abort
    #end
    #elsif
    #end
    puts "FILE TEMPLATE GET: #{template_path}"
    puts
    puts "#{option}"
    puts "NEXT STEP"
    labels = File.readlines("#{template_path}")
    labels.map! {|x| x.chomp }
    labels.reject! { |c| c.empty? }
    puts "File Array #{labels}"
    puts labels
    labels.each do |word|
      label_hash[word] = "#{word}"
      @labels << word
    end
    puts "EQUALS: #{@labels}"
    puts label_hash
    labelsize = self.get_labelsizes
    puts labelsize
    #textfound = self.check_text_for_labels(line)
    #puts textfound
    return label_hash
  end

  def check_text_for_labels(line)
    label_found = {}
    # Check if the line starts with capitalized word followed by :
    puts "Linestart #{line}"
    puts line.class
    if line =~ /^[A-Z ]+:/ then
      line2 = line.scan(/^[A-Z ]+:/).first
      # Place that word in array
      line_arr = line.scan(/^[A-Z ]+:/)
      puts "LINEARRAY #{line_arr}"
      unless line_arr[0].nil? || line_arr[0] == 0
        line_arr[0].chomp!(":")
        line2.nil? ? nil : line2.chomp!(":")
        # check if any predefined labels match the word
        if !(@labels & line_arr).empty? then
          puts "MATCHED #{line}"
          puts line2
          puts line_arr[0]
          line.slice! "#{line_arr[0]}:"
          puts line.length
          puts line.class
          puts line
          if line.length <= 1 then
            line = "NEITHER"
          end
          puts line
          line.strip!
          line.chomp!
          # addlabel and value to hash
          @labels.each do |label|
            label_found[label] = line if label == line_arr[0]
            puts line_arr[0]
          end
          puts "HASHTEST#{label_found}"
          puts "#{line_arr[0]} = #{line}"
          puts line_arr[1]
        end

      end
    end
    return label_found
  end

  def check_matches
    #if @labels.any? { |x| checkit.include?(x) } then
    if checkit.any? { |x| @labels.include?(x) } then
      puts "MATCHED"
      #if checkit.any? { |s| s.include?(@labels) } then
      puts "CHECK#{checkit}"
      puts "LABELS-#{@labels}"
    end
  end

  def get_labelsizes
    labelsize = []
    @labels.each_with_index do |value, index|
      labelsize[index] = (@labels[index].length+1)
      # we do the extra char because we want to include the : in the string
      # This prevents us from inadvertently catching a title or company name
      puts "#{value} IS #{labelsize[index]}"
    end
    puts labelsize
    return labelsize
  end

  def list_from_file(filename)
    list = File.readlines(filename)
    return list
  end

  def read_labels(filename, option)
    self.init_lize(filename)
    list = self.list_from_file(filename)
    list.reject! { |e| e.to_s.empty? }
    #list.uniq!
    #puts list
    #abort
    label_list = self.read_in_labels(filename, list, option)
    list = @list
    return label_list
  end

  def clean(input)
    input.gsub(/^[\s]*$\n/, "").strip
  end

  def read_in_labels(filename, list, option)
    #checkarrx = []
    label_hash = self.create_title_hash(option)
    #labelsize = self.get_labelsizes
    #puts "LENGTH #{labelsize} FOR #{label}"
    puts "LIST# #{list}"
    puts @labels
    list.reject! { |item| item.nil? || item == '' }
    list.each do |line|
      # Check if RECORD SET
      line.chomp!.strip!
      puts "THIS LINE #{line}"
      puts line.class
      puts line.length
      unless line.nil? || line == 0
        unless line.length == 0
          puts "The Line Length is #{line.length}"
          puts "LINE VALUE IS #{line}"
          puts "LINER#{line} and #{@labels[0]}"
          if line.start_with?("#{@labels[0]}:")
            @labels.each_with_index do | label, index |
              puts "HERE IS HASH##{label}"
              if label_hash[label].nil?
                label_hash[label] = "NOT_FOUND"
              end
              puts label_hash[label]
              puts "HERE IS HASH#"
            end
            label_hash["LIST"] = "#{@listname}"
            @records << label_hash
            puts "RECORD: #{@records}"
            label_hash = {}
          end
          label_found = self.check_text_for_labels(line)
          puts "Label Found #{label_found}"
          unless label_found.empty? || label_found.nil?
            puts "LABEL_FOUND#{label_found}"
            label_hash.merge!(label_found)
          end
        end
      end

      # puts "MATCH #{line}"
      # line2 = line[labelsize..-1]
      # line2 = line2.strip
      # checkarrx << line2
    end
    puts "RECORD# #{@records}"
    return @records
  end

  def get_text_afterlabels(line, labelsize)
    puts "TEST"
  end

  def array_to_file
    checkarrx.reject! { |item| item.nil? || item == '' }
    puts checkarrx

    newfile = "#{filename}.new"
    File.open(newfile, "w+") do |f|
      f.puts(checkarrx)
    end

    @list = checkarrx
    puts "NOW #{checkarrx}"
    puts "THEN"
    return checkarrx
  end

  def list_run(filename, label)
    list = self.list_test(filename, label)
    puts list
    return list
  end

  def buildlist_run(filename, option, template_path)
    @template_path = template_path
    puts "TEMPLATE LOCATION #{@template_path}"
    newlist = self.read_labels(filename, option)
    puts "#{option.upcase} #{newlist}"
    @converter.init_lize(filename)
    @converter.convert_DATA_to_CSV(newlist)
  end

  def contacts_run(filename)
    option = "people"
    newlist = self.read_labels(filename, option)
    puts "PEOPLE #{newlist}"
    @converter.init_lize(filename)
    @converter.convert_DATA_to_CSV(newlist)
  end

  def companies_run(filename)
    option = "companies"
    newlist = self.read_labels(filename, option)
    puts "COMPANIES ARE #{newlist}"
    @converter.init_lize(filename)
    @converter.convert_DATA_to_CSV(newlist)
  end

  # def list_test(filename, label)
  #   list = self.read_labels(filename)
  #   return list
  # end

end



#x = LabeltoCleanList.new

#x.companies_run("StartList")
#x.list_run("StartList", "COMPANY")
#("StartList", "COMPANY")
#x.test_bad_companies
