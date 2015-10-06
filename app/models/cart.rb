# Cart stored in session. Keeps item ids with corresponding counts
class Cart
  def initialize(session)
    @session = session

    # Session serialization converts hash keys to strings so convert back
    @cart = if @session[:cart] then
              Hash[@session[:cart].map {|(k, v)| [k.to_i, v.to_i]}]
            else
              Hash.new
            end

    # Always set default (may deserialize from session without default?)
    @cart.default = 0
  end

  # Returns list of CartItem contained in cart
  def items
    Item.find(@cart.keys).map do |item|
      CartItem.new(self, item, @cart[item.id])
    end
  end

  # Returns CartItem for given id. It can be updated to change quantity.
  def item_for(id)
    CartItem.new(self, Item.find(id.to_i), @cart[id.to_i])
  end

  # Save modified cart back to session
  def save
    @session[:cart] = @cart
  end

  # Returns quantity of item with given Item id as key
  def [](key)
    @cart[key]
  end

  # Updates item quantity, creates item if necessary. If quantity is 0 or
  # less, removes item from cart
  def []=(key, value)
    if value <= 0
      @cart.delete key
    else
      @cart[key] = value
    end
  end
end
