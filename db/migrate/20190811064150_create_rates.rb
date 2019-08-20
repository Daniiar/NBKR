# frozen_string_literal: true

class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.date :created_date
      t.string :currency
      t.decimal :exchange_rate
    end
  end
end
