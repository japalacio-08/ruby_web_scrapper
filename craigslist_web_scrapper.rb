# frozen_string_literal: true
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'fakefs/safe'
FakeFS do; end


BED = 3
BATH = 2
CITY = 'lakeland'

class CraigslistWebScrapper

  attr_accessor :bed, :bath, :city, :doc, :site, :entries, :mapped_entries

  def initialize(bed, bath, city)
    @bed = bed
    @bath = bath
    @city = city
    @site = "https://#{@city}.craigslist.org/search/hhh?min_bedrooms=#{@bed}&max_bedrooms=#{@bed}&min_bathrooms=#{@bath}&max_bathrooms=#{@bath}&availabilityMode=0"
  end

  def get_html_site
    @doc = Nokogiri::HTML(URI.open(@site))
  end

  def get_entries
    get_html_site
    @entries = @doc.css('.result-row')
  end

  def map_entries
    get_entries
    @mapped_entries = []
    @entries.each do |entry|
      title = entry.css('h3.result-heading>a').text
      url = entry.css('h3.result-heading>a')[0]['href']
      rent = entry.css('.result-meta').css('.result-price').text
      address = entry.css('span.result-hood').text
      @mapped_entries << Entry.new(title, url, rent, address)
    end
  end

  def map_entries_as_csv
    map_entries
    CSV.open('craigslist_results.csv', 'w') do |csv|
      csv << ["Title", "URL", "Rent", "Address"]
      @mapped_entries.each do |row|
        csv << [row.title, row.url, row.rent, row.address]
      end
    end
  end
  
  

end


class Entry
  def initialize(title, url, rent, address)
    @title = title
    @url = url
    @rent = rent
    @address = address
  end
  attr_reader :title, :url, :rent, :address
end



# entries = CraigslistWebScrapper.new(BED, BATH, CITY).map_entries_as_csv()