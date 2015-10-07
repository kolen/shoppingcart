require 'test_helper'

class PriceSummaryTest < ActiveSupport::TestCase
  test "basic functionality works" do
    cart_items = [CartItem.new(nil, items(:tea1), 4),
                  CartItem.new(nil, items(:tea2), 5)]
    price_summary = PriceSummary.new(cart_items)

    assert_equal 16.94 + 20.00, price_summary.sum_price
    assert_equal (16.94 + 20.00) - 9.99, price_summary.total_price
  end
end
