class MakePriceNotNull < ActiveRecord::Migration
  def change
    change_column_null :items, :price, false, '0.00'
  end
end
