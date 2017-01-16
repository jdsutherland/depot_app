require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test "it calculates a total price" do
    cart = Cart.new
    cart.add_product(products(:ruby))
    cart.add_product(products(:ruby))

    total = cart.total_price

    assert_equal total, products(:ruby).price * 2
  end
end
