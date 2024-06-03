class ScrapedPage < ApplicationRecord
  validates :url, presence: true, uniqueness: true

  def keyword_mentions(keywords: [])
    return nil if keywords.empty?

    regex = /\b(#{keywords.join('|')})\b/i
    doc = Nokogiri::HTML(body)
    texts = doc.xpath('//p | //a | //div').map(&:text).map(&:strip).uniq

    matches = texts.select { |text| text.match?(regex) }

    if matches.any?
      related_texts = matches.join("\n\n")
      { related_texts: related_texts }
    else
      nil
    end
  end
end
