require_relative '../support/acceptance_tests_helper'

resource 'Historical' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  explanation 'Endpoints to #historical for a Hourly temperature for the last 24 hours'

  route 'api/v1/accuweathers/historical', 'historical' do
    route_summary 'Starts a new request for a Hourly temperature for the last 24 hours with AccuWeather.COM'
    route_description 'Given valid credentials(API_KEY), will create a new API request for a Hourly temperature for the last 24 hours'

    get 'We get information from AccuWeather', document: :v1 do
      parameter :country, 'The country name', scope: :country, required: true
      parameter :city, 'The city name', scope: :city, required: true
      parameter :temperature, 'The temperature metric value', scope: :temperature, required: true
      parameter :temperature_unit, 'The temperature metric unit', scope: :temperature_unit, required: true
      parameter :weather_text, 'The weather text for - cloudy...', scope: :weather_text, required: true
      parameter :weather_icon, 'The weather icon for - img', scope: :weather_icon, required: true
      parameter :is_day_time, 'The is day time - true ore false', scope: :is_day_time, required: true

      example 'Ok - Hourly temperature for the last 24 hours', document: :v1 do
        request = { current: { city: 'Almaty' } }

        do_request(request)

        expect(status).to eq(200)
        expect(json.keys.size).to eq(7)
        expect(json['city']).to eq('Almaty')
      end
    end
  end
end
