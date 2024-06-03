class Finder
  attr_writer :keywords, :first, :last

  def keyword_mentions
    scope = ScrapedPage.all
    scope = scope.first(@first) if @first
    scope = scope.last(@last) if @last

    scope.each do |page|
      result = page.keyword_mentions(keywords: @keywords)
      if result
        puts "✅ HIT #{page.url}"
        puts result[:related_texts]
        puts "\n"
      else
        puts "❌ MISS #{page.url}"
      end

      puts "-" * 60
    end
  end

  private

  def initialize(keywords:, first: nil, last: nil)
    @keywords = keywords
    @first = first
    @last = last
  end
end
