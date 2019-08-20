# frozen_string_literal: true

class NBKR
  def self.check_record_existing(currency)
    Rate.where(created_date: Date.today, currency: currency).exists?
  end

  def self.create_record(currency, rate)
    rate = rate.split(',').join('.')
    date = Date.today.strftime('%d.%m.%Y')
    Rate.create(created_date: date, currency: currency, exchange_rate: rate)
  end

  def self.update_record(currency, rate)
    rate = rate.split(',').join('.')
    record = Rate.find_by(created_date: Date.today, currency: currency)
    record.update_attribute(:exchange_rate, rate)
  end

  def self.hash_rates
    NBKRExchangeRates.get_hash_of_rates
  end

  def self.get_rate_from_base_today(currency)
    record = Rate.where(created_date: Date.today, currency: currency)
    record[0].exchange_rate
  end

  def self.execute_request
    hash_rates.each do |currency, rate|
      if check_record_existing(currency)
        update_record(currency, rate) if get_rate_from_base_today(currency) != rate
      else
        create_record(currency, rate)
      end
    end
  end
end
