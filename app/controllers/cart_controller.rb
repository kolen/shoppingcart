class CartController < ApplicationController
  def index
    @cart = Cart.new(session)
    #@cart[1] = 3
    #@cart.save
    puts "Session cart", session[:cart]
    #session.delete :cart
  end

  def update
    @cart = Cart.new(session)

    item = @cart.item_for params[:id]
    item.update(params[:cart_item])
    if item.save
      @cart.save
      redirect_to action: 'index'
    else
      @failed_item = item
      render 'index'
    end
  end

  def add
    @cart = Cart.new(session)
    item = @cart.item_for params[:id]
    item.quantity += 1
    item.save
    @cart.save

    redirect_to :back, notice: "Item added to cart"
  end
end
