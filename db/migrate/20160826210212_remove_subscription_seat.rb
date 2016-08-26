class RemoveSubscriptionSeat < ActiveRecord::Migration
  def change
    drop_table :spree_subscription_seat
  end
end
