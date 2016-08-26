class AddSubscriptionSeat < ActiveRecord::Migration
  def change
    create_table :spree_subscription_seats do |t|
      t.references :user
      t.references :account_subscription
    end

    add_index :spree_subscription_seats, :user_id
    add_index :spree_subscription_seats, :account_subscription_id

  end
end
