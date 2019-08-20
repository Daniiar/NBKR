# frozen_string_literal: true

class RatesController < ApplicationController
  def index
    @rates = Rate.all
  end
end
