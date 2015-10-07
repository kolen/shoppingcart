class Tag < ActiveRecord::Base
  has_many :items, through: :item_tags
end
