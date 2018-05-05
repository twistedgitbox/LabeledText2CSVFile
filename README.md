# LabeledText2CSVFile
This makes it easy to take data from cut/paste text files and convert them into usable CSVs regardless of format.

Run 
Create_CSV_From_LabeledText.rb Filename Template

The templates are listed in LabelReader.rb in lib directory

So far the selection is:
company
company_full
person

What the program does is read the file and look for labels in the LABEL: format. That is a line that begins in word in UPPERCASE and followed by a colon.

When it finds this word, it checks it against the template. If the word is in the template, it saves the rest of the line in a hash which it then saves to a CSV.

So to use, get a text file (generally cut and paste data) and paste labels in front of the data you want to capture. 

Then adjust the templates to use the data you want, or use the templates provided. It will save it in a CSV file in the ./export folder with the name of the text file you used to have it scan.

It will also save the name of the list with the records to make it easy to see where the information came from.

