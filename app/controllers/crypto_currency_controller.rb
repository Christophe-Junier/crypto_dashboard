class CryptoCurrencyController < ApplicationController
    helper CryptoCurrencyHelper
    helper FormattedTimeHelper

    def index
        @crypto_currency = CryptoCurrency.find(permitted_params)
        @crypto_currency_items = {}
        @crypto_currency.crypto_currency_historical_values.map {|k| @crypto_currency_items[k.created_at] = k.value }
                
    end

    private

    def permitted_params
        params.require(:id)
    end

end