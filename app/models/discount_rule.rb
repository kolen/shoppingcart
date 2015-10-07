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
end
