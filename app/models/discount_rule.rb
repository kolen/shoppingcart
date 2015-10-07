class DiscountRule < ActiveRecord::Base
  belongs_to :item
  belongs_to :tag

  validates :item, presence: true, unless: :tag_based?
  validates :tag, presence: true, unless: :item_based?
  validate :cannot_be_both_item_and_tag_based
  validates :price_discount, presence: true, unless: :percentage_based?
  validates :percentage_discount, presence: true, unless: :price_based?
  validate :cannot_be_both_price_and_percentage_discount
  validates :quantity, presence: true, numericality: true,
            inclusion: { in: 1..100 }

  def item_based?
    item.present?
  end

  def tag_based?
    tag.present?
  end

  def price_based?
    price_discount.present?
  end

  def percentage_based?
    percentage_discount.present?
  end

  def cannot_be_both_item_and_tag_based
    if item.present? && tag.present?
      errors[:base] << "Rule can't be triggered both by item and tag"
    end
  end

  def cannot_be_both_price_and_percentage_discount
    if price_discount.present? && percentage_discount.present?
      errors[:base] << "Rule can't contain both price and percentage discount"
    end
  end

  # Returns what number of times this discount rule applies to items in cart
  # (repeating discounts can apply multiple times)
  def num_times_applies(cart_items)
    num_items_matched = cart_items.map do |cart_item|
      item_matches?(cart_item.item) ? cart_item.quantity : 0
    end.inject(:+)

    num_discounts = num_items_matched / quantity

    if repeating?
      num_discounts
    else
      if num_discounts > 0 then 1 else 0 end
    end
  end

  # Returns true if item matches this discount rule
  def item_matches?(checked_item)
    if item_based?
      item == checked_item
    else
      checked_item.tags.include? tag
    end
  end

  def repeating?
    repeating
  end
end
