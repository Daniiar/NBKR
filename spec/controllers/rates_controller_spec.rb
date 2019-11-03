# frozen_string_literal: true

require 'rails_helper.rb'

RSpec.describe RatesController do
  it 'should get root path' do
    get :main_page
    expect(response).to be_successful
  end
end

RSpec.describe RatesController do
  it 'should get search rates by dates and currency path' do
    counter = 1
    5.times do
      date = Date.new(2019, 9, 9)
      Rate.create(created_date: date + counter, currency: 'USD', exchange_rate: 69.5623)
      Rate.create(created_date: date + counter, currency: 'EUR', exchange_rate: 78.4567)
      counter += 1
    end
    get :search_rates_by_dates_and_currency, params: {
      'utf8' => '✓',
      'start_date' => { '(1i)' => '2019', '(2i)' => '10', '(3i)' => '1' },
      'end_date' => { '(1i)' => '2019', '(2i)' => '11', '(3i)' => '10' },
      'currency' => 'EUR',
      'commit' => 'Search',
      'controller' => 'rates',
      'action' => 'search_rates_by_dates_and_currency'
    }
    expect(response).to be_successful
  end
end
