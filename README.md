# README

### CSV Challenge

- Write a web scraper that will generate a csv of all the 3 bedroom, 2 bathroom homes for rent in a given city on Craigslist.
- The CSV should have the following columns: title, address (if available), monthly rent (if available), URL to original listing.

The App required me to use Nokogiri, Open-URI, CSV.

## Install the dependencies

<pre>
$ bundle install
</pre>

## For running the web scrapper

Uncomment the line on file `craigslist_web_scrapper.rb`
<pre>
entries = CraigslistWebScrapper.new(BED, BATH, CITY).map_entries_as_csv()
</pre>

Then

<pre>
$ ruby craigslist_web_scrapper.rb
</pre>

The script will return a `craigslist_results.csv` file


## For running the tests

Comment the line on file `craigslist_web_scrapper.rb`
<pre>
# entries = CraigslistWebScrapper.new(BED, BATH, CITY).map_entries_as_csv()
</pre>

Then

<pre>
$ bundle exec rspec  
</pre>