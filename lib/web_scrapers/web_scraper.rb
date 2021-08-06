class WebScraper
  require 'open-uri'

  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def call
    scrape
  end

  private

  def scrape
    Nokogiri::HTML(URI.parse(url).open)
  end
end
