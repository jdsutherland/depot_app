class Product < ApplicationRecord
  MINIMUM_PRICE = 0.01

  validates :title, :description, :image_url,
            presence: true
  validates :title, length: { minimum: 10 }
  validates :price, numericality: { greater_than_or_equal_to: MINIMUM_PRICE }
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: { with: %r{\.(gif|jpg|png)\Z}i,
                                                     message: 'must be a URL for GIF, JPG or PNG image.' }
end
