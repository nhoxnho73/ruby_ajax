class Subscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.integer :plan_id
      t.string :email
      t.string :stripe_customer_token
      t.string :paypal_customer_token
      t.string :paypal_recurring_profile_token
    
      t.timestamps
    end
    
  end
end
