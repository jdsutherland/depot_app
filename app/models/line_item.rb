class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price * quantity
  end

  def decrement_quantity!
    if quantity > 1
      self.quantity -= 1
      save
    else
      destroy
    end
    self
  end
end
