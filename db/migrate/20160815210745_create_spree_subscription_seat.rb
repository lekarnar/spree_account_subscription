class CreateSpreeSubscriptionSeat < ActiveRecord::Migration
  def change
    create_table :spree_subscription_seat do |t|
      t.references :user
      t.references :account_subscription
    end

    add_index :spree_subscription_seat, :user_id
    add_index :spree_subscription_seat, :account_subscription_id

  end
end
