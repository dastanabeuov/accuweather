require 'rails_helper'

describe 'GET #max', type: :request do
  subject { get '/api/v1/accuweathers/historical/max', as: :json }

  it 'returns success' do
    subject
    expect(json['status']).to have_http_status 200
  end

  it "returns the max temperature data" do
    subject
    expect(json['Temperature']['Metric']['Value']).to_not be nil
  end
end