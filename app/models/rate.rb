# frozen_string_literal: true

class Rate < ApplicationRecord
  validates_uniqueness_of :created_date, scope: :currency

  validates :created_date, presence: true
  validates :currency, presence: true
  validates :exchange_rate, presence: true

  validate :validate_date
  validate :validate_rate

  def validate_date
    condition1 = created_date.is_a?(Integer)
    condition2 = created_date.is_a?(Float)
    errors.add(:created_date, 'it is not a date, it is a number') if condition1 || condition2
  end

  def validate_rate
    condition = 0
    errors.add(:exchange_rate, 'it is not BigDecimal, it is String') if exchange_rate == condition
  end
end
