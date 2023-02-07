require 'rails_helper'

RSpec.describe 'AccuweatherService' do
  specify '#current' do
    geocode_stub = double 'GeocodeService', city_search: 'Almaty'
    response_stub = double 'AccuweatherService', current: geocode

    expect(json['Temperature']['Metric']['Value']).to_not be nil
  end

  specify '#historical' do
    geocode_stub = double 'GeocodeService', city_search: 'Almaty'
    response_stub = double 'AccuweatherService', historical: geocode

    expect(json['Temperature']['Metric']['Value']).to_not be nil
  end

  specify '#max' do
    geocode_stub = double 'GeocodeService', city_search: 'Almaty'
    response_stub = double 'AccuweatherService', max: geocode

    expect(json['Temperature']['Metric']['Value']).to_not be nil
  end
end