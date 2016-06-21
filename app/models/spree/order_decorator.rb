module Spree
  Order.class_eval do
    def create_subscriptions
      line_items.each do |line_item|
        if line_item.variant.subscribable?
          Subscription.subscribe!(
            email: self.email, 
            product: line_item.variant.product,
            start_datetime: DateTime.now,
            end_datetime: DateTime.now + 365.days
          )
        end
      end
    end
  end
end
