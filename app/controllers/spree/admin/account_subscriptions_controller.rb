module Spree
  module Admin
    class AccountSubscriptionsController < ResourceController
      before_filter :load_data, except: :index

      def show
        redirect_to( action: :edit )
      end

      def index
        params[:q] ||= {}
        @search = Spree::AccountSubscription.search(params[:q])
        @account_subscriptions = @search.result.page(params[:page]).per(15)
        puts "Subscriptions: #{@account_subscriptions.count}"
      end

      def create
        create_or_update Spree.t("subscription_successfully_created")
      end

      def update
        create_or_update Spree.t("subscription_successfully_updated")
      end

      protected

      def load_data
        @products = Product.subscribable.all.map { |product| [product.name, product.id] }
        @emails = Spree::User.all.map { |user| [user.email, user.email]}
      end

      private

      def create_or_update(flash_msg)
        if @account_subscription.update_attributes(subscription_params)
          redirect_to edit_admin_account_subscription_path(@account_subscription)
          flash.notice = flash_msg
        else
          respond_with(@account_subscription)
        end
      end

      def subscription_params
        params.require(:account_subscription).permit(:email, :product_id, :start_datetime, :end_datetime)
      end
    end
  end
end
