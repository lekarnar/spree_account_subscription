module Spree
  module Api
    module V1
      class AccountSubscriptionsController < Spree::Api::BaseController

        require "time"
        before_action :find_account_subscription


        def show
          authorize! :show, @account_subcription

          #status in the case that subscription has lapsed
          status=211

          if !@account_subcription
            #no subscription, no content to send
            status=212

          else

            dif = @account_subcription.end_datetime - DateTime.now
            expires_in dif, :public => true

            response.headers["Expires"] = @account_subcription.end_datetime.httpdate

            if DateTime.now < @account_subcription.end_datetime

              #subscription is ok
              status=200

            end


          end


          render nothing: true, :status => status
        end


        private


          def find_account_subscription(lock = false)
            #check if user is subscription owner
            unless get_by_user_id
              #otherwise look for a subscription seat
              get_by_token
            end
            puts "account subscription? #{@account_subcription}"
          end

          def get_by_user_id
            @account_subcription = Spree::AccountSubscription.
                order(:end_datetime).
                find_by(user_id: params[:user_id])
          end

          def get_by_token
            subscription = Spree::AccountSubscription
                                       .find_by(token: params[:registration_code])

            puts "getting by token : #{subscription}"
            if subscription
              seat = get_subscription_seat subscription
              puts "found subscription seat: #{seat}"
            end

            if seat
              puts "setting @account subscription"
              @account_subcription = subscription
            end

          end

          def get_subscription_seat( subscription )
            user_id = params[:user_id]
            puts "getting subscription seat for user: #{user_id}"
            seat = subscription.get_seat user_id
            puts "Checked for existing seat: #{seat}"
            unless seat
              seat = subscription.take_seat user_id
              puts "no existing seat, try taking a new one: #{seat}"
            end

            seat
          end

      end
    end
  end
end
