require 'rails_helper'

describe 'GET #current', type: :request do
  subject { get '/api/v1/accuweathers/current', as: :json }

  it 'returns success' do
    subject
    expect(json['status']).to have_http_status 200
  end

  it "returns the current temperature data" do
    subject
    expect(json['Temperature']['Metric']['Value']).to_not be nil
  end
end
