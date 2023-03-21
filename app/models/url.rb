class Url < ApplicationRecord
  validates :original_url, presence: true, format: URI::regexp(%w[http https]) ## follow a format
  validates :short_url, presence: true, uniqueness: true # ensure uniqueness
  before_validation :generate_short_url

  private

  # create a short url if one is not already there
  def generate_short_url
    self.short_url = SecureRandom.hex(4) if short_url.blank?
  end
end
