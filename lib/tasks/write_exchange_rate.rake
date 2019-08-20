# frozen_string_literal: true

desc 'this task sends request and writes exchange rates to database'
task :write_exchange_rates, [:parameter] => :environment do
  data = NBKRExchangeRates.get_hash_of_rates
  Dir.glob("#{Rails.root}/app/controllers/*.rb").each { |file| require file }

  data.each do |currency, rate|
    rate = rate.split(',').join('.')
    Rate.create(date: Date.today.strftime('%d.%m.%Y'), currency: currency, exchange_rate: rate)
  end
end

# TODO
# create file example readme.md and write below line
# * * * * * /bin/bash -l -c 'cd /home/daniiar/Desktop/NBKR && rails write_exchange_rates'
