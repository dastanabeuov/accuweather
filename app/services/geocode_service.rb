class GeocodeService
  BASE_URL = 'http://dataservice.accuweather.com'.freeze
  
  def self.search_location(default_location)
    connect = Faraday.new(BASE_URL) do |f|
      f.request :json # encode req bodies as JSON and automatically set the Content-Type header
      f.request :retry # retry transient failures
      f.response :json # decode response bodies as JSON
    end
    response = connect.get('/locations/v1/cities/search?', {
      apikey: Rails.application.credentials.accuweather_api_key,
      q: default_location,
    })
    data = response.body.first
    geocode = OpenStruct.new
    geocode.key  = data["Key"].to_i
    geocode.latitude = data["GeoPosition"]["Latitude"].to_f
    geocode.longitude = data["GeoPosition"]["Longitude"].to_f
    geocode.country_code = data["Country"]["ID"]
    geocode.country = data["Country"]["LocalizedName"]
    geocode.city = data["LocalizedName"]
    geocode
    #binding.pry
  end

  # This method send request with gem 'geocoder'
  # def self.call(address)
  #   response = Geocoder.search(address)
  #   data = response.first.data
  #   geocode = OpenStruct.new
  #   geocode.latitude  = data["lat"].to_f
  #   geocode.longitude = data["lon"].to_f
  #   geocode.country_code = data["address"]["country_code"]
  #   geocode.country = data["address"]["country"]
  #   geocode.city = data["address"]["city"]
  #   geocode
  # end
end