class OrderItem < ApplicationRecord

  enum making_status: { not_start: 0, waiting: 1, doing: 2, done: 3 }

end
