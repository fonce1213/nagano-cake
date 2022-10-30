class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  validates :item_id, presence: true
  validates :order_id, presence: true
  validates :price, presence: true
  validates :amount, presence: true
  validates :making_status, presence: true

  enum making_status: { not_start: 0, waiting: 1, doing: 2, done: 3 }

end
