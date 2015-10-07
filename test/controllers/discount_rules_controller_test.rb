require 'test_helper'

class DiscountRulesControllerTest < ActionController::TestCase
  setup do
    @discount_rule = discount_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:discount_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create discount_rule" do
    assert_difference('DiscountRule.count') do
      post :create, discount_rule: { description: @discount_rule.description, item_id: @discount_rule.item_id, percentage_discount: @discount_rule.percentage_discount, price_discount: @discount_rule.price_discount, tag_id: @discount_rule.tag_id }
    end

    assert_redirected_to discount_rule_path(assigns(:discount_rule))
  end

  test "should show discount_rule" do
    get :show, id: @discount_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @discount_rule
    assert_response :success
  end

  test "should update discount_rule" do
    patch :update, id: @discount_rule, discount_rule: { description: @discount_rule.description, item_id: @discount_rule.item_id, percentage_discount: @discount_rule.percentage_discount, price_discount: @discount_rule.price_discount, tag_id: @discount_rule.tag_id }
    assert_redirected_to discount_rule_path(assigns(:discount_rule))
  end

  test "should destroy discount_rule" do
    assert_difference('DiscountRule.count', -1) do
      delete :destroy, id: @discount_rule
    end

    assert_redirected_to discount_rules_path
  end
end
