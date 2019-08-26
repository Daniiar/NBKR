# frozen_string_literal: true

require 'test_helper'

class RateTest < ActiveSupport::TestCase
  test 'the model Rate should not save empty fields or any field' do
    rate = Rate.new
    assert_not(rate.save)

    record = Rate.create(created_date: nil, currency: 'EUR', exchange_rate: 69.0001)
    assert_not(record.save)

    record = Rate.create(created_date: Date.today, currency: nil, exchange_rate: 69.0001)
    assert_not(record.save)

    record = Rate.create(created_date: Date.today, currency: 'EUR', exchange_rate: nil)
    assert_not(record.save)
  end

  test 'the model Rate should not save if record with date and currency already exists' do
    date = Date.new(2019, 8, 11)
    rate = BigDecimal('69.4545')
    record = Rate.create(created_date: date, currency: 'USD', exchange_rate: rate)
    assert_not(record.save)
  end

  test 'the record saved successfully' do
    date = Date.new(2000, 1, 1)
    rate = BigDecimal('29.4545')
    record = Rate.create(created_date: date, currency: 'USD', exchange_rate: rate)
    assert(record.save)
    binding.pry
  end
end
