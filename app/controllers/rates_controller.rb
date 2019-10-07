# frozen_string_literal: true

class RatesController < ApplicationController
  def main_page
    @quantity_of_records = Rate.count
    @rates = Rate.last(8)
  end

  def search_rates_by_dates_and_currency
    @currency = params['currency']

    start_date = RateHelper.parse_date(params['start_date'])
    end_date = RateHelper.parse_date(params['end_date'])
    range = { created_date: start_date..end_date }
    sorted = Rate.where(range)

    @sorted = sorted.where(currency: @currency)
  end
end
