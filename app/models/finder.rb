class Finder
  attr_writer :keywords, :first, :last

  def find_and_log
    ScraperLogger.logger.info "Searching for keywords"

    scope = ScrapedPage.all
    scope = scope.first(@first) if @first
    scope = scope.last(@last) if @last

    scope.each do |page|
      result = page.keyword_mentions(keywords: @keywords)
      if result
        ScraperLogger.logger.info "✅ HIT #{page.url}"
        ScraperLogger.logger.info result[:related_texts]
        ScraperLogger.logger.info "\n"
      else
        ScraperLogger.logger.info "❌ MISS #{page.url}"
      end

      ScraperLogger.logger.info "-" * 60
    end

    nil
  end

  private

  # keywords - Array of keywords to search for, e.g.:
  #   ["api", "openapi", "automation", "rest", "graphql", "rpc", "soap", "webhook", "scrap", "event-driven", "serializ"]
  # first - Integer, the number of pages to search through
  # last - Integer, the number of pages to search through
  def initialize(keywords:, first: nil, last: nil)
    ScraperLogger.logger.info "Initialize logger for #{keywords.join(", ")}"

    @keywords = keywords
    @first = first
    @last = last
  end
end
