# LabeledText2CSVFile
This makes it easy to take data from cut/paste text files and convert them into usable CSVs regardless of format.

Run the following format

Create_CSV_From_LabeledText.rb DataFilename TemplateName

The templates are listed in `Label_Templates` Directory

RULES FOR TEMPLATES:
ONLY CAPITAL LETTERS
No spaces or non-alphabet characters

What the program does is read the file and look for labels in the LABEL: format. That is a line that begins in word in UPPERCASE and followed by a colon.

When it finds this word, it checks it against the template. If the word is in the template, it saves the rest of the line in a hash which it then saves to a CSV.

So to use, get a text file (generally cut and paste data) and paste labels in front of the data you want to capture.

Then adjust the templates to use the data you want, or use the templates provided.

READ LOCATION:
Files read are from the `Root Directory`. The data file must be in
the same directory as the `Create_CSV_From_LabeledText.rb` file.

EXPORT LOCATION:
It will save it in a CSV file in the ./export folder as 'DataFilename.csv'
(Example running on a datafile name 'Scan1' would be saved as Scan1.csv)

DATAFILES:
Datafiles are text files with LABELs added corresponding to a template in the
Label_Templates directory. If no data is available for LABEL in template - it
should enter NOT_FOUND_


It will also save the name of the list with the records to make it easy to see where the information came from.

