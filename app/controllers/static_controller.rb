class StaticController < ApplicationController

	def index
	end


	def api

		resp = RestClient.get("https://www.metaweather.com/api/location/1154781")
		hash = JSON.parse(resp.body)
		@weathers = hash["consolidated_weather"]

		resp2 = RestClient.get("https://talaikis.com/api/quotes/random/")
		hash = JSON.parse(resp2.body)
		@quote = hash["quote"]
		@author = hash["author"]
		@cat = hash["cat"]
		
		resp3 = RestClient.get("http://api.icndb.com/jokes/random")
		hash = JSON.parse(resp3.body)
		@joke = hash["value"]["joke"]
		

	end



end
