describe Api::V1::AccuweathersController, type: :routing do
  describe 'Routing from AccuweathersController' do
    it '#current' do
      expect(get: "/api/v1/accuweathers/current").to route_to("api/v1/accuweathers#current")
    end

    it '#historical' do
      expect(get: "/api/v1/accuweathers/historical").to route_to("api/v1/accuweathers#historical")
    end

    it '#max' do
      expect(get: "/api/v1/accuweathers/historical/max").to route_to("api/v1/accuweathers#max")
    end
  end
end
