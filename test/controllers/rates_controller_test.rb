# frozen_string_literal: true

require 'test_helper'

class RatesControllerTest < ActionDispatch::IntegrationTest
  test 'should get root path' do
    get root_path
    assert_response :success
  end
end
