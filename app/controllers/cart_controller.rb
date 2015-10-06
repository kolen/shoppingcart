class CartController < ApplicationController

  CartItem = Struct.new("CartItem", :item, :quantity)

  # Cart stored in session. Keeps item ids with corresponding counts
  class Cart
    def initialize(session)
      @session = session
      @cart = @session[:cart] || Hash.new(0)
    end

    def items
      Item.find(@cart.keys).map do |item|
        CartItem.new(item, @cart[item.id])
      end
    end

    def save
      @session[:cart] = @cart
    end

    def [](key)
      @cart[key]
    end

    def []=(key, value)
      if value <= 0
        @cart.delete key
      else
        @cart[key] = value
      end
    end
  end
end
