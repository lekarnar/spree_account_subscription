Spree::Api::V1::UsersController.class_eval do
  before_filter :include_user_subscriptions, only: [:show, :account_subscriptions]

  def account_subscriptions
    respond_with(@account_subscriptions)
  end

  private

  def include_user_subscriptions
    @account_subscriptions = user.account_subscriptions.order(:end_datetime)
  end
end
