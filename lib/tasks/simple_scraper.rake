namespace :scraper do
  desc "Run the SimpleScraper"
  task run: :environment do
    base_url = ENV['BASE_URL']
    from = ENV['FROM'] ? ENV['FROM'].to_i : 1
    to = ENV['TO'] ? ENV['TO'].to_i : nil

    begin
      uri = URI.parse(base_url)
      unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
        puts "Invalid BASE_URL. Please provide a valid URL."
        exit 1
      end
    rescue URI::InvalidURIError
      puts "Invalid BASE_URL. Please provide a valid URL."
      exit 1
    end

    scraper = SimpleScraper.new(base_url, from: from, to: to)
    scraper.crawl
  end
end
