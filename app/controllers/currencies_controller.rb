class CurrenciesController < ApplicationController
  def first_currency
   @raw_data = open("https://api.exchangerate.host/symbols").read
   @parsed_data = JSON.parse(@raw_data)
   @symbols_hash = @parsed_data.fetch("symbols")
   @array_of_symbols = @symbols_hash.keys

    render ({ :template => "currency_templates/step_one.html.erb" })
  end

  def second_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")
    @array_of_symbols = @symbols_hash.keys
    @from_symbol= params.fetch("from_currency")
 
     render ({ :template => "currency_templates/step_two.html.erb" })
   end

   
     def third_currency
      @from_symbol = params.fetch("from_currency").to_sym
      @to_symbol = params.fetch("to_currency").to_sym
  
      @raw_data = open("https://api.exchangerate.host/convert?from=#{@from_symbol}&to=#{@to_symbol}").read
      @parsed_data = JSON.parse(@raw_data)
      @symbols_hash = @parsed_data.fetch("query")
      @from = @symbols_hash.fetch("from")
      @to = @symbols_hash.fetch("to")
      @amount = @parsed_data.fetch("info")
      @rate= @amount.fetch("rate")

      
  
      render({ :template => "currency_templates/step_three.html.erb" })
    end

  


end
