class WebScraper
  require 'open-uri'
  require 'watir'

  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def call
    scrape
  end

  private

  def scrape
    browser = Watir::Browser.new :chrome, headless: true
    browser.goto url
    Nokogiri::HTML.parse(browser.html)
  end
end
