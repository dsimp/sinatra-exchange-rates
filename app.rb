require "sinatra"
require "sinatra/reloader"
require "http"



get("/") do  
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  @raw_response = HTTP.get(api_url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)
  @currencies = @parsed_data.fetch("currencies")

  erb(:homepage)

 
end

get("/:got_symbol") do
  @the_symbol = params.fetch("got_symbol")
  
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  @raw_response = HTTP.get(api_url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)
  @currencies = @parsed_data.fetch("currencies")

  erb(:one_page)
end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  @api_url = "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"

  @raw_response = HTTP.get(@api_url)
  @string_response = @raw_response.to_s
  @parsed_response = JSON.parse(@string_response)
  @amount = @parsed_response.fetch("result")

  erb(:two_page)


  
end
