module Spree
  UsersController.class_eval do
    before_filter :include_user_subscriptions, only: :show

    private

    def include_user_subscriptions
      @account_subscriptions = Spree::AccountSubscription.where(user_id: @user.id)
    end
  end
end