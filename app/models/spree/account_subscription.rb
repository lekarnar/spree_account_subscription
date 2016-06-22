class Spree::AccountSubscription < ActiveRecord::Base
  belongs_to :product, class_name: 'Spree::Product'

  belongs_to :user, class_name: Spree.user_class

  scope :canceled, -> { where(state: :canceled) }

  state_machine :state, initial: :active do
    event :cancel do
      transition to: :canceled, if: :allow_cancel?
    end
  end

  def self.subscribe!(opts)
    opts.to_options!.assert_valid_keys(:email, :user, :product, :start_datetime, :end_datetime)

    existing_subscription = self.where(email: opts[:email], user_id: opts[:user].id, product_id: opts[:product].id).first

    if existing_subscription
      self.renew_subscription(existing_subscription, opts[:end_datemime])
    else
      self.new_subscription(opts[:email], opts[:user], opts[:product], opts[:start_datetime], opts[:end_datetime])
    end
  end

  def ended?
    DateTime.now > end_datetime
  end

  def ending?
    DateTime.now - 30.days > end_datetime
  end

  def canceled?
    return state.intern == :canceled
  end

  def notify_ended!
    if Spree::Subscriptions::Config.use_delayed_job
      Spree::SubscriptionMailer.delay.subscription_ended_email(self)
    else
      Spree::SubscriptionMailer.subscription_ended_email(self).deliver
    end
  end

  def notify_ending!
    if Spree::Subscriptions::Config.use_delayed_job
      Spree::SubscriptionMailer.delay.subscription_ending_email(self)
    else
      Spree::SubscriptionMailer.subscription_ending_email(self).deliver
    end
  end

  def allow_cancel?
    self.state != 'canceled'
  end

  private

  def self.new_subscription(email, user, product, start_datetime, end_datetime)
    self.create do |s|
      s.email            = email
      s.user_id         = user.id
      s.product_id      = product.id
      s.start_datetime = start_datetime
      s.end_datetime     = end_datetime
    end
  end

  def self.renew_subscription(old_subscription, new_end_datetime)
    old_subscription.update_attribute(:end_datetime, new_end_datetime)
    old_subscription
  end
end
