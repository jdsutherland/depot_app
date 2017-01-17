require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  def setup
    @line_item = LineItem.new
    @line_item.product = products(:ruby)
  end

  test "it calculates a total price using quantity" do
    @line_item.quantity = 2

    total = @line_item.total_price

    assert_equal total, products(:ruby).price * 2
  end

  test "it can decrement quantity" do
    @line_item.quantity = 2

    @line_item.decrement_quantity!

    assert_equal @line_item.quantity, 1
  end

  test "it destroys a line item when quantity is decremented to zero" do
    @line_item.quantity = 1

    @line_item.decrement_quantity!

    assert @line_item.destroyed?
  end
end
