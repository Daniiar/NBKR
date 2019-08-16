# frozen_string_literal: true

class RatesController < ApplicationController
  http_basic_authenticate_with name: 'dhh', password: 'secret', except: %i[index show]

  def index
    @rates = Rate.all
    @rates_from_nbkr = NBKRExchangeRates.get_hash_of_rates
  end

  def show
    @rate = Rate.find(params[:id])
  end

  def new
    @rate = Rate.new
  end

  def edit
    @rate = Rate.find(params[:id])
  end

  def create
    @rate = Rate.new(rate_params)

    if @rate.save
      redirect_to @rate
    else
      render 'new'
    end
  end

  def update
    @rate = Rate.find(params[:id])

    if @rate.update(rate_params)
      redirect_to @rate
    else
      render 'edit'
    end
  end

  def destroy
    @rate = Rate.find(params[:id])
    @rate.destroy

    redirect_to rates_path
  end

  private

  def rate_params
    params.require(:rate).permit(:date, :currency, :exchange_rate)
  end
end
