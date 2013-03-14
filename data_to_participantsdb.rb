### ITZ BROKEN. GAWDDAWN.
require 'time'
require 'csv'

# make sure elements in array are all lowercase
TECH_TYPES = ['website', 'cad', 'programming', 'computer', 'hardware', 'software', 'hand tools', 'power tools', 'database', 'general programming']
PERSON_OPTIONS = ['family']

new_csv = File.open('data_formatted_for_upload.csv', 'w') # open exisiting file for overwriting
hopeless = File.open('data_defies_formatting.txt', 'w') # also overwrites, change to 'a' if you'd rather append

# See Participants Database > Import CSV File page for current headers
# Insert headers as first line
new_csv << 'story,posneg,year_occurred,month_occurred,how_old,tech_type,person_involved,tech_savvy,id' << "\n"

# http://ruby-doc.org/stdlib-1.9.3/libdoc/csv/rdoc/CSV.html
old_csv = File.read('data.csv') # read old csv file
csv = CSV.parse(old_csv, headers: true, skip_blanks: true) # parse file contents as CSV

temp = {}
id_start = 2 #replace with value of last index
id = id_start

# hash currently screwed when text has comma in it (value assigned to wrong keys, some values have no keys)
csv.each do |row_raw|
	id+= 1

	row = row_raw.to_hash
	#row = row.to_hash.with_indifferent_access
	
	temp[:story] = row['Text']
	# more logic needed if value not always 'positive'/'negative'/nil
	temp[:posneg] = row['Polarity']
	unless row['StartDate'].nil? || row['StartDate'].empty?
		temp[:year_occurred] = Date.parse(row['StartDate']).year
		temp[:month_occurred] = Date.parse(row['StartDate']).month
	end
	temp[:how_old] = row['Age'] ? row['Age'].gsub('Age ', '') : nil
	unless row['Tag'].nil? || row['StartDate'].empty?
		temp[:tech_type] = row['Tag'] if TECH_TYPES.include?(row.fetch('Tag', '').downcase)
		temp[:person_involved] = row['Tag'] if PERSON_OPTIONS.include?(row.fetch('Tag', '').downcase)
	end

	# why isn't the file changing?!
	# why does it all go into new_csv still?
	if temp[:posneg] == "positive" || temp[:posneg] == "negative"
		p temp[:posneg]
		# assumes no tech_savvy value
		new_csv.puts "#{temp.values.join(',')},,#{id}\n"
	else #Do it manually!
		p "else! #{temp[:posneg]}"
		p row_raw
		hopeless.puts "#{row_raw}\n"
	end
end

#gender and event ignored for now

new_csv.close
hopeless.close	
	
	
	

