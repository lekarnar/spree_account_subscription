Spree::Payment.class_eval do
  delegate :create_subscriptions, to: :order

  state_machine initial: :checkout do
    after_transition to: :completed, do: :create_subscriptions
  end
end
