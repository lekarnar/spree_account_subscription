class AddSeatsToSpreeAccountSubscription < ActiveRecord::Migration
  def change
    add_column :spree_account_subscriptions, :num_seats, :integer, default: 1
    add_column :spree_account_subscriptions, :authorization_code, :string, default: nil, limit:256
  end
end
