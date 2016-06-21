module Spree
  Variant.class_eval do
    before_save :set_default_subscription_length

    delegate :subscribable?, to: :product

    def set_default_subscription_length
      self.subscription_length = Spree::Subscriptions::Config.default_subscrption_length if !self.subscrption_length
    end
  end
end
