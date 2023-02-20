require_relative '../support/acceptance_tests_helper'

resource 'Min' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  explanation 'Endpoints to #min for a min temperature for the last 24 hours'

  route 'api/v1/accuweathers/historical/min', 'min' do
    route_summary 'Starts a new request for a min temperature for the last 24 hours with AccuWeather.COM'
    route_description 'Given valid credentials(API_KEY), will create a new API request for a min temperature for the last 24 hours'

    get 'We get information from AccuWeather', document: :v1 do
      parameter :country, 'The country name', scope: :country, required: true
      parameter :city, 'The city name', scope: :city, required: true
      parameter :min_temperature_24_hour, 'The temperature metric value', scope: :temperature, required: true
      parameter :temperature_unit, 'The temperature metric unit', scope: :temperature_unit, required: true

      example 'Ok - min temperature for the last 24 hours', document: :v1 do
        request = { current: { city: 'Almaty' } }

        do_request(request)

        expect(status).to eq(200)
        expect(json.keys.size).to eq(7)
        expect(json['city']).to eq('Almaty')
      end
    end
  end
end
