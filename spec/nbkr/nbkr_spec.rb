# frozen_string_literal: true

require 'rails_helper.rb'

RSpec.describe 'NBKR' do
  it 'hash_rates' do
    expect(NBKR.hash_rates).to be_kind_of Hash
    expect(NBKR.hash_rates).not_to be_empty
    expect(NBKR.hash_rates).not_to be_nil
  end

  it 'execute_request(create_record and update_record)' do
    current_hash = { 'USD' => '69,8490', 'EUR' => '77,3578', 'KZT' => '0,1803', 'RUB' => '1,0465' }
    NBKR.execute_request(current_hash)

    expect(Rate.last.created_date).to eq(Date.today)
    expect(Rate.last.currency).to eq('RUB')
    expect(Rate.last.exchange_rate.to_s).to eq('1.0465')

    current_hash = { 'USD' => '70,1111', 'EUR' => '78,2222', 'KZT' => '1,3333', 'RUB' => '2,4444' }
    NBKR.execute_request(current_hash)

    expect(Rate.last.created_date).to eq(Date.today)
    expect(Rate.last.currency).to eq('RUB')
    expect(Rate.last.exchange_rate.to_s).to eq('2.4444')
  end

  it 'write logs' do
    expect(File.read('log/nbkr.log').include?('https://www.nbkr.kg/XML/daily.xml 2019-08-29'))
  end
end
