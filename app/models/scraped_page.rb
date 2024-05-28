class ScrapedPage < ApplicationRecord
  validates :url, presence: true, uniqueness: true
end
