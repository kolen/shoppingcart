require 'bigdecimal'

# Calculates discounts and resulting price of order
class PriceSummary
  DiscountInfo = Struct.new(:text, :times, :amount)

  attr_reader :sum_price, :active_discounts, :total_price

  # Creates summary from list of CartItem
  def initialize(cart_items)
    @cart_items = cart_items
  end

  # Returns list of active discounts (DiscountInfo)
  def active_discounts
    DiscountRule.all.flat_map do |rule|
      num_times_applies = rule.num_times_applies @cart_items

      if num_times_applies > 0
        [DiscountInfo.new(rule.description, num_times_applies,
                          discount_amount(rule))]
      else
        []
      end
    end
  end

  # Returns total price (after applied discounts)
  def total_price
    @total_price ||= sum_price - active_discounts.map(&:amount).inject(&:+)
  end

  # Returns price of sum of all items' prices (before discounts)
  def sum_price
    @sum_price ||= @cart_items.map { |ci| ci.item.price }.inject(:+)
  end

  private

  def discount_amount(rule)
    if rule.price_based?
      rule.price_discount
    else
      BigDecimal.mode(BigDecimal::ROUND_MODE, :up)
      BigDecimal.new(rule.percentage_discount)
        .mult(BigDecimal.new('0.01'), 2)
        .mult(sum_price, 2)
    end
  end
end
