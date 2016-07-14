module Spree
  module Api
    module V1
      class AccountSubscriptionsController < Spree::Api::BaseController
        VALID_SUBSCRIPTION = 200
        EXPIRED_SUBSCRIPTION = 211
        NO_SUBSCRIPTION = 212

        before_action :find_account_subscription, :authorize_account_subscription

        def show
          set_expiry_headers if @account_subscription
          head subscription_status_code
        end

        private

        def find_account_subscription
          @account_subcription = Spree::AccountSubscription
            .order(:end_datetime)
            .find_by(user_id: params[:user_id])
        end

        def authorize_account_subscription
          authorize! params[:action].to_sym, @account_subcription
        end

        def set_expiry_headers
          diff = @account_subcription.end_datetime - Time.now.utc
          expires_in diff, public: true
          response.headers['Expires'] = @account_subcription.end_datetime.httpdate
        end

        def subscription_status_code
          case
          when @account_subscription.nil? then NO_SUBSCRIPTION
          when @account_subscription.ended? then EXPIRED_SUBSCRIPTION
          else VALID_SUBSCRIPTION
          end
        end
      end
    end
  end
end
