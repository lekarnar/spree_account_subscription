class AddOrderToSpreeAccountSubscription < ActiveRecord::Migration
  def change
    change_table :spree_account_subscriptions do |t|
      t.references :order
    end

    add_index :spree_account_subscriptions, :order_id

  end
end
