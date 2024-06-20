require "httparty"
require "nokogiri"

class SimpleScraper
  def initialize(base_url, from: 1, to: 10)
    @base_url = base_url
    @from = from
    @to = to

    puts "Crawler initialized"
  end

  def crawl
    puts "Start crawling"

    current_page = @from
    consecutive_404s = 0

    while @to.nil? || current_page <= @to
      puts "Crawling page #{current_page}"

      url = "#{@base_url}/#{current_page}"
      response = HTTParty.get(url)

      if response.code == 404
        consecutive_404s += 1
        break if consecutive_404s >= 3
      else
        consecutive_404s = 0
        scrape(response.body, url)
      end

      current_page += 1
      sleep 1
    end

    puts "Crawling finished with #{ScrapedPage.count} pages now available"
  end

  def scrape(page_content, url)
    # Parse the HTML and extract the <body> element including the tag
    parsed_page = Nokogiri::HTML(page_content)
    body_content = parsed_page.at("body").to_html

    # Find or initialize the ScrapedPage record and update the body
    scraped_page = ScrapedPage.find_or_initialize_by(url: url)
    scraped_page.body = body_content
    scraped_page.save!
  end
end
