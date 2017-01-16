require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  test "it calculates a total price" do
    line_item = LineItem.new
    line_item.product = products(:ruby)
    line_item.quantity = 2

    total = line_item.total_price

    assert_equal total, products(:ruby).price * 2
  end
end
