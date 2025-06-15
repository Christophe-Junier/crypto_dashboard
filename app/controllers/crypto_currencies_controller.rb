class CryptoCurrenciesController < ApplicationController
    helper CryptoCurrencyHelper
    helper FormattedTimeHelper

    def index
        @crypto_currencies = CryptoCurrency.all
    end

end