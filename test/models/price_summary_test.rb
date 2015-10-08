require 'test_helper'

class PriceSummaryTest < ActiveSupport::TestCase
  test "basic functionality works" do
    cart_items = [CartItem.new(nil, items(:tea1), 4),
                  CartItem.new(nil, items(:tea2), 5)]
    price_summary = PriceSummary.new(cart_items)

    sum = 16.94 * 4 + 20.00 * 5

    assert_equal sum, price_summary.sum_price
    assert_equal sum - 9.99, price_summary.total_price
  end
end
