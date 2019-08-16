# frozen_string_literal: true

class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.date :date
      t.string :currency
      t.decimal :exchange_rate

      t.timestamps
    end
  end
end
