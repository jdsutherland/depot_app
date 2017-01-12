require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
  end

  test "displays product with price" do
    PRICE_REGEX = /\$[,\d]+\.\d\d/
    product = products(:ruby)

    get store_index_path

    assert_template 'store/index'
    assert_select 'h3', product.title
    assert_select '.price', PRICE_REGEX
  end

end
