# frozen_string_literal: true

desc 'this task sends request and writes exchange rates to database'
task :write_exchange_rates, [:parameter] => :environment do
  NBKR.execute_request(NBKR.hash_rates)
end
