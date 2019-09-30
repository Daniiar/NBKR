# frozen_string_literal: true

module RateHelper
  def self.parse_date(date_params)
    date_params = date_params.transform_values(&:to_i)

    year = date_params['(1i)']
    month = date_params['(2i)']
    day = date_params['(3i)']

    Date.new(year, month, day)
  end
end
