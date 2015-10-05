class CartController < ApplicationController

  # Cart stored in session. Keeps item ids with corresponding counts
  class Cart
    def initialize(session)
      @session = session
      @cart = @session[:cart] || []
    end

    def items
      Item.find(@cart.map(&:first))
    end

    def increment(id)
      modify id { |i| i+1 }
    end

    def decrement(id)
      modify id { |i| i-1 }
    end

    def set(id, value)
      modify id { |i| value }
    end

    def save
      @session[:cart] = @cart
    end

    private

    # Modifies count of item with id with modifier. Creates new item with 0
    # count before passing it to modifier if item with this id is not yet in
    # cart
    def modify(id, &modifier)
      index = @cart.find_index |i| i.first == id
      if index.nil?
        # Create new item and put to the end of cart list
        @cart << [id, 0]
        index = @cart.length - 1
      end

      # Update item in card with count passed through modifier
      @cart[index] = [id, modifier.call(@cart[index][1])]
    end
  end
end
