class Item < ActiveRecord::Base
  validates :title, presence: true
  has_many :tags, through: :item_tag, dependent: :destroy
end
