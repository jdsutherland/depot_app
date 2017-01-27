require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  fixtures :products

  def setup
    @start_order_count = Order.count
    @ruby_book = products(:ruby)
  end

  test "buying a product" do
    get store_index_path

    post line_items_path, params: { product_id: @ruby_book.id }, xhr: true

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal @ruby_book, cart.line_items.first.product

    get new_order_path

    assert_difference "Order.count", 1 do
      perform_enqueued_jobs do
        post orders_path, params: {
          order: {
            name:     "Dave Thomas",
            address:  "123 The Street",
            email:    "dave@example.com",
            pay_type: "Check",
          },
        }
      end
    end

    follow_redirect!
    assert_template 'store/index'

    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
  end
end
