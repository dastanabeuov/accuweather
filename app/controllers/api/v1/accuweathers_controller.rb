module Api
  module V1
    class AccuweathersController < Api::V1::ApiController
      skip_before_action :authenticate_user!
      skip_after_action :verify_authorized, :verify_policy_scoped

      before_action :set_location

      def current
        @current = AccuweatherService.current(@geocode)
        render json: { action: "current", current: @current }, status: 200
      end

      def historical
        @historical = AccuweatherService.historical(@geocode)
        render json: { action: "historical", historical: @historical }, status: 200
      end

      def max
        @max = AccuweatherService.max(@geocode)
        render json: { action: "max", max: @max }, status: 200
      end

      private

      def set_location
        default_location = "Almaty"
        @geocode ||= GeocodeService.search_location(default_location)
      end
    end
  end
end
