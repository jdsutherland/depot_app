class AddPriceToLineItem < ActiveRecord::Migration[5.0]
  def change
    add_column :line_items, :price, :decimal

    LineItem.includes(:product).find_each do |li|
      li.update(price: li.product.price)
    end
  end
end
