module Spree
  Order.class_eval do

    def create_subscriptions
      line_items.each do |line_item|
        logger.debug "CREATINGSUBSCRIPTION: #{line_item} QUANTITY: #{line_item.quantity}, and self: #{self}"
        if line_item.variant.subscribable?
          AccountSubscription.subscribe!(
            email: self.email,
            user: self.user,
            product: line_item.variant.product,
            start_datetime: DateTime.now,
            end_datetime: DateTime.now + 365.days,
            order: self,
            num_seats: line_item.quantity
          )
          line_item.quantity=1
        end
      end
    end
  end
end
