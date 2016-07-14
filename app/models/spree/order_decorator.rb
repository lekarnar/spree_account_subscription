Spree::Order.class_eval do
  def create_subscriptions
    line_items.subscribable.each do |line_item|
      AccountSubscription.subscribe!(
        email: email,
        user: user,
        product: line_item.variant.product
      )
    end
  end
end
