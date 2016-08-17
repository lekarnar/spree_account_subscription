class RemoveAuthorizationCodeFromSpreeAccountSubscription < ActiveRecord::Migration
  def change
    remove_column :spree_account_subscriptions, :authorization_code, :string
  end
end
