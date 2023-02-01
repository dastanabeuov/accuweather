# frozen_string_literal: true
class AccuweatherForCurrentService  
  def self.current(geocode)
    connect = Faraday.new(GeocodeService::BASE_URL) do |f|
      f.request :json # encode req bodies as JSON and automatically set the Content-Type header
      f.request :retry # retry transient failures
      f.response :json # decode response bodies as JSON
    end
    response = connect.get('/currentconditions/v1/locationKey?', {
      apikey: Rails.application.credentials.accuweather_api_key,
      locationKey: geocode.key,
      #details: true, #unlock this line, if need more info
    })
    body = response.body.first
    current = OpenStruct.new
    current.country = geocode.country
    current.city = geocode.city
    current.temperature = body["Temperature"]["Metric"]["Value"]
    current.temperature_unit = body["Temperature"]["Metric"]["Unit"]
    current.weather_text = body["WeatherText"]
    current.weather_icon = body["WeatherIcon"]
    current.is_day_time = body["IsDayTime"]
    current
    #binding.pry
  end
end