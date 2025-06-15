class CreateCryptoCurrencies < ActiveRecord::Migration[7.2]
  def change
    create_table :crypto_currencies do |t|
      t.timestamps
      t.string :fullname
      t.string :shortname
      t.integer :value
    end
  end
end
