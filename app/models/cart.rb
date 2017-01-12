class Cart < ApplicationRecord
  has_many :line_item, dependent: :destroy
end
