class PagesController < ApplicationController
  def home
    symbols = %w[AUD USD VND SGD JPY MMK SGD TWD PHP KPW KRW MYR INR HKD CNY]
    response = HTTParty.get("http://api.exchangeratesapi.io/v1/latest?access_key=#{ENV['EXCHANGE_RATE_API_KEY']}&symbols=#{symbols.join(',')}")
    @rates = []
    @base_on = nil
    if response["success"]
      @rates = response["rates"]
      @base_on = response["base"]
    end
  end
end
