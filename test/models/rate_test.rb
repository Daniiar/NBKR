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

  test 'the record saved successfully' do
    date = Date.new(2000, 1, 1)
    rate = BigDecimal('29.4545')
    record = Rate.create(created_date: date, currency: 'USD', exchange_rate: rate)
    assert(record.save)
  end

  test 'the model Rate should not save if record with date and currency already exists' do
    date = Date.new(2019, 8, 11)
    rate = BigDecimal('69.4545')
    record = Rate.create(created_date: date, currency: 'USD', exchange_rate: rate)
    assert_not(record.save)
  end

  test 'created_date - the record should not to save a number or string to field created_date' do
    rate = BigDecimal('29.4545')

    record = Rate.create(created_date: 2017, currency: 'USD', exchange_rate: rate)
    assert_not(record.save)

    record = Rate.create(created_date: 2017.07, currency: 'USD', exchange_rate: rate)
    assert_not(record.save)

    record = Rate.create(created_date: 'asdf', currency: 'USD', exchange_rate: rate)
    assert_not(record.save)

    record = Rate.create(created_date: '2016.09.', currency: 'USD', exchange_rate: rate)
    assert_not(record.save)
  end

  test 'created_date - the record saved successfully if created_date is string in valid format' do
    rate = BigDecimal('29.4545')

    record = Rate.create(created_date: '2017-08-05', currency: 'USD', exchange_rate: rate)
    assert(record.save)

    record = Rate.create(created_date: '2017.08.06', currency: 'USD', exchange_rate: rate)
    assert(record.save)
  end

  test 'exchange_rate - record saved successfully(correct format)' do
    date = Date.new(2020, 8, 11)
    rate = BigDecimal('69.4545')

    record = Rate.create(created_date: date, currency: 'USD', exchange_rate: rate)
    assert(record.save)

    record = Rate.create(created_date: date, currency: 'KGS', exchange_rate: 69)
    assert(record.save)

    record = Rate.create(created_date: date, currency: 'FRA', exchange_rate: '69')
    assert(record.save)
  end

  test 'exchange_rate - record should not to be saved with string' do
    date = Date.new(2020, 8, 11)
    record = Rate.create(created_date: date, currency: 'KZT', exchange_rate: 'rate')
    assert_not(record.save)
  end
end
