# frozen_string_literal: true

require 'rails_helper.rb'
require 'webmock/rspec'

RSpec.describe 'NBKR' do
  it 'hash_rates' do
    xml = File.read('./spec/nbkr/nbkr.xml')
    stub_request(:get, 'https://www.nbkr.kg/XML/daily.xml').to_return(status: 200, body: xml)

    nbkr_rates = NBKR.hash_rates
    expected_rates = { 'USD' => '69,8500',
                       'EUR' => '77,0236',
                       'KZT' => '0,1804',
                       'RUB' => '1,0715' }

    expect(nbkr_rates).to eq(expected_rates)
  end

  it 'write_to_base' do
    nbkr_rates = { 'USD' => '70,1111',
                   'EUR' => '78,2222',
                   'KZT' => '1,3333',
                   'RUB' => '2,4444' }

    NBKR.write_to_base(nbkr_rates)
    last_record = Rate.last

    expect(last_record.created_date).to eq(Date.today)
    expect(last_record.currency).to eq('RUB')
    expect(last_record.exchange_rate.to_s).to eq('2.4444')
  end
end

RSpec.describe 'NBKR logs' do
  it 'write logs' do
    xml = File.read('./spec/nbkr/nbkr.xml')
    stub_request(:get, 'https://www.nbkr.kg/XML/daily.xml').to_return(status: 200, body: xml)

    nbkr_rates = NBKR.hash_rates
    NBKR.write_logs(nbkr_rates)

    logs_text = File.read('log/nbkr.log')
    time_of_last_line = Time.parse(logs_text[-97..-73])
    time_diference = Time.now - time_of_last_line

    expect(logs_text.include?('https://www.nbkr.kg/XML/daily.xml ' + Date.today.to_s)).to eq(true)
    expect(logs_text.include?(nbkr_rates.to_s)).to eq(true)
    expect(time_diference < 60).to eq(true)
  end
end
