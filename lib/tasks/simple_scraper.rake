namespace :scraper do
  desc "Run the SimpleScraper"
  task run: :environment do
    ScraperLogger.logger.info "Running SimpleScraper"

    base_url = ENV["BASE_URL"]
    from = ENV["FROM"]&.to_i || 1
    to = ENV["TO"]&.to_i

    begin
      uri = URI.parse(base_url)
      unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
        ScraperLogger.logger.error "Invalid BASE_URL. Please provide a valid URL."
        exit 1
      end
    rescue URI::InvalidURIError
      ScraperLogger.logger.error "Invalid BASE_URL. Please provide a valid URL."
      exit 1
    end

    scraper = SimpleScraper.new(base_url, from: from, to: to)
    scraper.crawl

    ScraperLogger.logger.info "SimpleScraper completed"
  end

  desc "Run finder"
  task finder: :environment do
    ScraperLogger.logger.info "Running finder"

    finder = Finder.new(keywords: ["api", "openapi", "auto
      mation", "rest", "graphql", "rpc", "soap", "webhook", "scrap", "
      event-driven", "serializ"])
    finder.find_and_log

    ScraperLogger.logger.info "Finder completed"
  end
end
