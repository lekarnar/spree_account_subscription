class Spree::SubscriptionSeat < ActiveRecord::Base
  belongs_to :account_subscription, class_name: 'Spree::AccountSubscription'

  belongs_to :user, class_name: Spree.user_class

  validates :user, uniqueness: { scope: :account_subscription,
                                    message: "only one redemption per user and subscription"}

  def self.redeem!(opts)
    opts.to_options!.assert_valid_keys(:user, :account_subscription)

    self.new_redemption(opts[:user], opts[:account_subscription])
  end


  private

  def self.new_redemption( user, account_subscription )
    self.create do |s|
      s.user_id                      = user.id
      s.account_subscription_id      = account_subscription.id
    end
  end

end
