# frozen_string_literal: true
# spec/craigslist_web_scraper_spec.rb
require_relative "../craigslist_web_scrapper.rb"

SITE_BASE = "https://#{CITY}.craigslist.org/search/hhh?min_bedrooms=#{BED}&max_bedrooms=#{BED}&min_bathrooms=#{BATH}&max_bathrooms=#{BATH}&availabilityMode=0".dup

describe CraigslistWebScrapper do
  before :each do
    @scrapper = CraigslistWebScrapper.new(BED, BATH, CITY)
  end
  describe ".get_site" do
    context "given the params" do
      it "returns the site url" do
        expect(@scrapper.site).to eq(SITE_BASE)
      end
    end
  end

  describe ".get_entries" do
    context "given the params" do
      it "returns the scrapper entries" do
        @scrapper.get_entries
        expect(@scrapper.entries.length).to be > 0
      end
    end
  end

  describe ".map_entries" do
    context "given the params" do
      it "returns the mapped entries" do
        @scrapper.map_entries
        expect(@scrapper.mapped_entries.length).to eq(@scrapper.entries.length)
      end
    end
  end
end