require 'bigdecimal'

# Calculates discounts and resulting price of order
class PriceSummary
  DiscountInfo = Struct.new(:text, :times, :amount_or_percent, :amount)

  attr_reader :sum_price, :active_discounts, :total_price

  # Creates summary from list of CartItem
  def initialize(cart_items)
    @sum_price = cart_items.map { |ci| ci.item.price }.inject(:+)
    @active_discounts = DiscountRule.all.flat_map do |rule|
      num_times_applies = rule.num_times_applies cart_items

      # FIXME: extract
      if num_times_applies > 0
        amount_or_percent = if rule.price_based?
                              rule.price_discount
                            else
                              rule.percentage_discount
                            end
        amount = if rule.price_based?
                   rule.price_discount
                 else
                   BigDecimal.mode(BigDecimal::ROUND_MODE, :up)
                   BigDecimal.new(rule.percentage_discount)
                     .mult(BigDecimal.new("0.01"), 2)
                     .mult(@sum_price, 2)
                 end
        [DiscountInfo.new(rule.description, num_times_applies,
                          amount_or_percent, amount)]
      else
        []
      end
    end

    @total_price = @sum_price - @active_discounts.map(&:amount).inject(&:+)
  end


end
