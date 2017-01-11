require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products(:ruby)
  end

  test "should be valid" do
    assert @product.valid?
  end

  test "title should be present" do
    @product.title = ''

    assert_not @product.valid?
  end

  test "title should be at least 10 characters" do
    @product.title = 'a' * 9

    assert_not @product.valid?
  end

  test "description should be present" do
    @product.description = ''

    assert_not @product.valid?
  end

  test "image_url should be present" do
    @product.image_url = ''

    assert_not @product.valid?
  end

  test "price smaller than minimum is not valid" do
    @product.price = Product::MINIMUM_PRICE - 0.01

    assert_not @product.valid?
  end

  test "minimum price is valid" do
    @product.price = Product::MINIMUM_PRICE

    assert @product.valid?
  end

  test "title is unique" do
    duplicate_product = @product.dup

    @product.save

    assert_not duplicate_product.valid?
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
          http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(name).valid?
    end

    bad.each do |name|
      assert_not new_product(name).valid?
    end
  end

  private

  def new_product(image_url)
    product = Product.new(
      title:       'Example Product',
      description: 'Example description',
      image_url:   image_url,
      price:       3.99,
    )
  end
end
