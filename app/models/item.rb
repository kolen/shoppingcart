class Item < ActiveRecord::Base
  validates :title, presence: true
  has_many :item_tags
  has_many :tags, through: :item_tags, dependent: :destroy
end
