require 'test_helper'

class DiscountRuleTest < ActiveSupport::TestCase
  test "item_matches? works - match by item" do
    assert discount_rules(:one).item_matches?(items(:tea1))
    assert_not discount_rules(:one).item_matches?(items(:tea2))
  end

  test "item_matches? works - match by tag" do
    items(:tea2).tags << tags(:large_leaf)

    # rule :two has :large_leaf tag
    assert_not discount_rules(:two).item_matches?(items(:tea1))
    assert discount_rules(:two).item_matches?(items(:tea2))
  end

  test "num_times_applies works" do
    items = [CartItem.new(nil, items(:tea1), 5),
             CartItem.new(nil, items(:tea2), 8)]
    items(:tea2).tags << tags(:large_leaf)

    assert_equal 1, discount_rules(:one).num_times_applies(items)
    assert_equal 2, discount_rules(:two).num_times_applies(items)
  end
end
