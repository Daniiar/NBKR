# frozen_string_literal: true

class RatesController < ApplicationController
  def index
    @rates = Rate.all
  end

  def search
    @currency = params['currency']

    start_date = RateHelper.parse_date(params['start_date'])
    end_date = RateHelper.parse_date(params['end_date'])
    range = { created_date: start_date..end_date }
    sorted = Rate.all.where(range)

    @sorted = sorted.where(currency: @currency)
  end
end
