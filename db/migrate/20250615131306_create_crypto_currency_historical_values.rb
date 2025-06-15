class CreateCryptoCurrencyHistoricalValues < ActiveRecord::Migration[7.2]
  def change
    create_table :crypto_currency_historical_values do |t|
      t.timestamps
      t.string :fullname
      t.string :shortname
      t.float :value
      t.belongs_to :crypto_currency
    end
  end
end
