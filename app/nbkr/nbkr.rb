# frozen_string_literal: true

class NBKR
  def self.hash_rates
    NBKRExchangeRates.get_hash_of_rates
  end

  def self.write_logs(info)
    url = NBKRExchangeRates::URL.to_s
    date_time = Time.now.to_s
    info = info.to_s
    File.open('log/nbkr.log', 'a') { |f| f.write("#{url} #{date_time} #{info}" + "\n") }
  end

  def self.execute_request(data)
    data.each do |currency, rate|
      rate = rate.split(',').join('.')
      date = Date.today
      record = Rate.find_by(created_date: date, currency: currency)

      if record.nil?
        Rate.create(created_date: date, currency: currency, exchange_rate: rate)
      elsif record.exchange_rate.to_s != rate
        record.update_attribute(:exchange_rate, rate)
      end
    end
  end
end
