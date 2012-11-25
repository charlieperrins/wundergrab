# Get London's precipitation levels from Wunderground.com for any given date

# Set up the month you want to scrape data for, e.g. October 2011
YEAR=2011
MON=10
DAY=31

# Loop back through the days of the month from the last to the first
while [ $DAY -gt 0 ]; do
	
	# Hit Wunderground's summary page for the current day
	# Pass HTML document through a couple of greps to get the line containing precipitation levels
	# Return piped curl & greps to a variable
	FRAGMENT="`curl http://www.wunderground.com/history/airport/EGLL/$YEAR/$MON/$DAY/DailyHistory.html?req_city=London | grep -A2 '<span>Precipitation</span>' | grep '' | grep '<span class=\"b\">'`"
	
	# Build new line for our CSV, MYSQL formatted date string followed by HTML fragment
	OUTPUT=$YEAR-$MON-`printf "%02d" $DAY`,$FRAGMENT		
	
	# Append output as a new line to our CSV file
	echo $OUTPUT >>raw_data.txt
	
	# Decrease day counter and output status
	echo 'day written'
    let DAY=DAY-1

done
# Makes it easy to see in the terminal when the month has finished
echo 'month written'