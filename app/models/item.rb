class Item < ApplicationRecord

  validates :name, presence: true
  validates :introduction, presence: true
  belongs_to :genre
  validates :price, presence: true

  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  
  
  

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'dfault-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  def with_tax_price
    (price * 1.1).floor
  end
end
