# frozen_string_literal: true

desc 'this task sends request and writes exchange rates to database'
task :write_exchange_rates, [:parameter] => :environment do
  rates = NBKR.hash_rates
  NBKR.execute_request(rates)
  NBKR.write_logs(rates)
end
