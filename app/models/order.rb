class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  
  validates :customer_id, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :postage, presence: true
  validates :total_price, presence: true
  validates :payment, presence: true
  validates :order_status, presence: true

  enum payment: { credit_card: 0, transfer: 1 }
  enum order_status: { waiting_for_payment: 0, payment_confirmation: 1,
  doing: 2, preparing_to_ship: 3, sent: 4 }
end
