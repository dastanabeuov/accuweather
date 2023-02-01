module Api
  module V1
    class AccuweathersController < Api::V1::ApiController
      skip_before_action :authenticate_user!
      skip_after_action :verify_authorized, :verify_policy_scoped

      before_action :set_location

      def current
        #binding.pry
        current_weather_cache_key = "#{@geocode.country_code}/#{@geocode.country}"
        current_weather_cache_exist = Rails.cache.exist?(current_weather_cache_key)
        @current = Rails.cache.fetch(current_weather_cache_key, expires_in: 1.hours) do
          AccuweatherForCurrentService.current(geocode)
        end
      end

      private

      def set_location
        default_location = "Almaty"
        @geocode ||= GeocodeService.search_location(default_location)
      end
    end
  end
end
