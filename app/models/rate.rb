# frozen_string_literal: true

class Rate < ApplicationRecord
  validates_uniqueness_of :created_date, scope: :currency

  validates :created_date, presence: true
  validates :currency, presence: true
  validates :exchange_rate, presence: true
end
