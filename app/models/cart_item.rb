# Cart item position. When updated and saved, changes its quantity in Cart.
class CartItem
  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :item
  attr_accessor :quantity

  validates :quantity, numericality: true

  def initialize(cart, item, quantity)
    @cart, @item, @quantity = cart, item, quantity
  end

  def id
    @item.id
  end

  def update(values)
    self.quantity=(values[:quantity])
  end

  def save
    valid? && @cart[@item.id] = @quantity.to_i
  end
end
