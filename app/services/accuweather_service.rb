# frozen_string_literal: true
class AccuweatherService
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
    current.date_time = body["LocalObservationDateTime"]
    current
  end

  def self.historical(geocode)
    connect = Faraday.new(GeocodeService::BASE_URL) do |f|
      f.request :json # encode req bodies as JSON and automatically set the Content-Type header
      f.request :retry # retry transient failures
      f.response :json # decode response bodies as JSON
    end
    response = connect.get('/currentconditions/v1/locationKey/historical/24?', {
      apikey: Rails.application.credentials.accuweather_api_key,
      locationKey: geocode.key,
      #details: true, #unlock this line, if need more info
    })
    body = response.body
    body.each do |b|
      historical = OpenStruct.new
      historical.country = geocode.country
      historical.city = geocode.city
      historical.temperature = b["Temperature"]["Metric"]["Value"]
      historical.temperature_unit = b["Temperature"]["Metric"]["Unit"]
      historical.weather_text = b["WeatherText"]
      historical.weather_icon = b["WeatherIcon"]
      historical.is_day_time = b["IsDayTime"]
      historical.date_time = b["LocalObservationDateTime"]
      historical
    end
  end

  def self.max(geocode)
    connect = Faraday.new(GeocodeService::BASE_URL) do |f|
      f.request :json # encode req bodies as JSON and automatically set the Content-Type header
      f.request :retry # retry transient failures
      f.response :json # decode response bodies as JSON
    end
    response = connect.get('/currentconditions/v1/locationKey/historical/24?', {
      apikey: Rails.application.credentials.accuweather_api_key,
      locationKey: geocode.key,
      details: true, #unlock this line, if need more info
    })
    body = response.body
    #binding.pry
    b = body.sort_by { |obj| obj["TemperatureSummary"]["Past24HourRange"]["Maximum"]["Metric"]["Value"] }.last
    max = OpenStruct.new
    max.country = geocode.country
    max.city = geocode.city
    max.max_temperature_24_hour = b["TemperatureSummary"]["Past24HourRange"]["Maximum"]["Metric"]["Value"]
    max.temperature_unit = b["TemperatureSummary"]["Past24HourRange"]["Maximum"]["Metric"]["Unit"]
    max
  end
end