class AddTokenToAccountSubscription < ActiveRecord::Migration
  def change
    add_column :spree_account_subscriptions, :token, :string
  end
end
