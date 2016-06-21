class CreateSpreeAccountSubscriptions < ActiveRecord::Migration
  def change
    create_table :spree_account_subscriptions do |t|
      t.references :product
      t.string :email
      t.string :state
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.timestamps null: false
    end
  end
end
