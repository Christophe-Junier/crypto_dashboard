class UpdateCryptoCurrenciesJob
  include Sidekiq::Job

  def perform(*args)
      available_crypto = CryptoCurrency.pluck(:fullname)
      request = Faraday.get(
          'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest',
          params = { "start": '1', "limit": '100', 'convert':"EUR" },
          headers = { 'Content-Type' => 'application/json', 'X-CMC_PRO_API_KEY' => ENV["MARKET_TOKEN"] }
      )
      response = JSON.parse request.body
      response["data"].each do |data|
          if available_crypto.include? data["name"]
            crypto = CryptoCurrency.find_by_fullname(data["name"])
            crypto.update(value: data["quote"]["EUR"]["price"])
          end
      end
  end
end