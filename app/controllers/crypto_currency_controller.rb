class CryptoCurrencyController < ApplicationController
    helper CryptoCurrencyHelper
    helper FormattedTimeHelper

    def index
        @crypto_currency = CryptoCurrency.find(permitted_params)
    end

    private

    def permitted_params
        params.require(:id)
    end

end