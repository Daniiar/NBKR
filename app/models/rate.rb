class Rate < ApplicationRecord
  has_many :comments, dependent: :destroy
    
  validates :date, presence: true
  validates :currency, presence: true
  validates :exchange_rate, presence: true
end
