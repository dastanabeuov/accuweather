require 'rails_helper'

RSpec.describe 'GeocodeService' do
  specify '#city_search' do
    geocode_stub = double 'GeocodeService', city_search('Almaty')
    #subject { GeocodeService.city_search('Almaty') }

    #expect(json.first["LocalizedName"]).to be_eq 'Almaty'
    #expect(json.first["Country"]["ID"]).to be_eq 'KZ'
    #expect(json.first["Country"]["LocalizedName"]).to be_eq 'Kazakhstan'
    expect(geocode_stub.city_search('Almaty')).to eq('Almaty')
  end
end