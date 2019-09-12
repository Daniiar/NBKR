# frozen_string_literal: true

require 'rails_helper.rb'
require 'webmock/rspec'

RSpec.describe 'NBKR' do
  it 'hash_rates' do
    xml = File.read('./spec/nbkr/nbkr.xml')

    stub_request(:get, 'https://www.nbkr.kg/XML/daily.xml').to_return(status: 200, body: xml)

    hash = NBKR.hash_rates

    expect(hash).to be_kind_of Hash
    expect(hash).not_to be_empty
    expect(hash).not_to be_nil
  end

  it 'execute_request(create_record and update_record)' do
    current_hash = { 'USD' => '69,8490', 'EUR' => '77,3578', 'KZT' => '0,1803', 'RUB' => '1,0465' }
    NBKR.execute_request(current_hash)

    last_record = Rate.last

    expect(last_record.created_date).to eq(Date.today)
    expect(last_record.currency).to eq('RUB')
    expect(last_record.exchange_rate.to_s).to eq('1.0465')

    # current_hash = { 'USD' => '70,1111', 'EUR' => '78,2222', 'KZT' => '1,3333', 'RUB' => '2,444' }
    # NBKR.execute_request(current_hash)

    # last_record = Rate.last

    # expect(last_record.created_date).to eq(Date.today)
    # expect(last_record.currency).to eq('RUB')
    # expect(last_record.exchange_rate.to_s).to eq('2.4444')
  end
end

# RSpec.describe 'NBKR logs' do
#   it 'write logs' do
#     rates = NBKR.hash_rates
#     NBKR.write_logs(rates)
#     logs_text = File.read('log/nbkr.log')
#     time_of_last_line = Time.parse(logs_text[-97..-73])
#     time_diference = Time.now - time_of_last_line

#     expect(logs_text.include?('https://www.nbkr.kg/XML/daily.xml ' + Date.today.to_s)).to eq(true)
#     expect(logs_text.include?(NBKR.hash_rates.to_s)).to eq(true)
#     expect(time_diference < 60).to eq(true)
#   end
# end
