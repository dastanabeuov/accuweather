describe Api::V1::AccuweathersController, type: :routing do
  describe 'routing' do
    it 'routes to #current' do
      expect(get: "/api/v1/accuweathers/current").to route_to("api/v1/accuweathers#current")
    end
  end
end
