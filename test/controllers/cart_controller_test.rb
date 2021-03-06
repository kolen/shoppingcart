require 'test_helper'

class CartControllerTest < ActionController::TestCase
  test "Cart reads from session, access and items method works" do
    cart = CartController::Cart.new({:cart => {items(:tea1).id => 1,
                                               items(:tea2).id => 3}})
    cart[items(:tea1).id] += 1
    assert_equal [items(:tea1), items(:tea2)], cart.items.map(&:item)
    assert_equal [2, 3], cart.items.map(&:quantity)
  end

  test "Save works" do
    fake_session = {:cart => {items(:tea1).id => 2}}
    cart = CartController::Cart.new(fake_session)
    cart[items(:tea1).id] += 3
    cart.save

    assert_equal({items(:tea1).id => 5}, fake_session[:cart])
  end

  test "Treats assigning zero as removal" do
    cart = CartController::Cart.new({:cart => {items(:tea2).id => 1}})
    cart[items(:tea2).id] -= 1
    assert_equal [], cart.items
  end
end
