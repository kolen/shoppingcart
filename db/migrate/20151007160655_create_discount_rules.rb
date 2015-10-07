class CreateDiscountRules < ActiveRecord::Migration
  def change
    create_table :discount_rules do |t|
      t.text :description, null: false
      t.references :item, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
      t.decimal :price_discount, precision: 10, scale: 2
      t.decimal :percentage_discount, precision: 4, scale: 2

      t.timestamps null: false
    end
  end
end
