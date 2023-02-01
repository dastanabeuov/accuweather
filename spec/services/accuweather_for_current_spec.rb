require 'rails_helper'

RSpec.describe 'AccuweatherForCurrentService' do
  specify '#current' do
    geocode_stub = double 'GeocodeService', city_search: 'Almaty'
    response_stub = double 'AccuweatherForCurrentService', current: geocode

    #subject { GeocodeService.city_search('Almaty') }
    #subject { AccuweatherForCurrentService.current(geocode) }

    #expect(json["Temperature"]["Metric"]["Value"]).to_not be nil
    expect(response_geocode.call('Almaty KZ')).to eq('Almaty')
  end
end