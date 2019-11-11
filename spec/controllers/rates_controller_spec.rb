# frozen_string_literal: true

require 'rails_helper.rb'

RSpec.describe 'should get main page', type: :feature do
  fixtures :rates
  scenario 'action main_page' do
    visit root_path

    content = [
      "Total records: 8\nlast 8 records\ncreated_date currency exchange rate ",
      '02.01.2019 EUR 78.5224 ',
      '01.01.2019 KZT 0.1796 ',
      '01.01.2019 RUB 1.098 ',
      '01.01.2019 EUR 79.5224 ',
      '02.01.2019 KZT 1.1796 ',
      '02.01.2019 RUB 2.098 ',
      '01.01.2019 USD 69.9656 ',
      '02.01.2019 USD 68.9656'
    ]
    expect(page).to have_content(content.join)
  end
end

RSpec.describe 'should get result of search', type: :feature do
  fixtures :rates
  scenario 'action search_rates_by_dates_and_currency' do
    visit root_path

    content = [
      'exchange rate 01.01.2019 USD 69.9656 ',
      "02.01.2019 USD 68.9656\nLoading..."
    ]

    page.select '2019', from: 'start_date[(1i)]'
    page.select 'January', from: 'start_date[(2i)]'
    page.select '1', from: 'start_date[(3i)]'

    page.select '2019', from: 'end_date[(1i)]'
    page.select 'January', from: 'end_date[(2i)]'
    page.select '2', from: 'end_date[(3i)]'

    page.select 'USD', from: 'currency'
    click_on 'Search'

    expect(page).to have_content(content.join)
  end
end
