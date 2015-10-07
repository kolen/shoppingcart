class AddQuantityAndRepeatingToDiscountRule < ActiveRecord::Migration
  def change
    add_column :discount_rules, :quantity, :integer, null: false,
               default: 1
    add_column :discount_rules, :repeating, :boolean, null: false,
               default: false
  end
end
