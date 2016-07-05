Spree::Api::V1::UsersController.class_eval do
  before_filter :include_user_subscriptions, only: [:show, :account_subscriptions]

  def account_subscriptions
    puts "SUBSCRIPTIONS!!!! #{@account_subscriptions} #{@account_subscriptions.length}"
    respond_with(@account_subscriptions)
  end

  private

  def include_user_subscriptions
    @account_subscriptions = Spree::AccountSubscription.order(:end_datetime).where(user_id: user.id)
  end
end