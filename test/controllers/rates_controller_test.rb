# frozen_string_literal: true

require 'test_helper'

class RatesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get rate_index_url
    assert_response :success
  end
end
