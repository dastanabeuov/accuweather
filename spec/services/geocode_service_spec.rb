require 'rails_helper'

RSpec.describe 'GeocodeService' do
  specify '#search_location' do
    geocode_stub = double 'GeocodeService', search_location('Almaty')
    #subject { GeocodeService.search_location('Almaty') }

    #expect(json.first["LocalizedName"]).to be_eq 'Almaty'
    #expect(json.first["Country"]["ID"]).to be_eq 'KZ'
    #expect(json.first["Country"]["LocalizedName"]).to be_eq 'Kazakhstan'
    expect(geocode_stub.search_location('Almaty')).to eq('Almaty')
  end
end