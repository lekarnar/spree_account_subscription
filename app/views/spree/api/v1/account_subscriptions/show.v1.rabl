object @account_subscription

node(:product) { |a| a.product.id }
node(:user) { |a| a.user.id }
node(:email) { |a| a.email }
node(:state) { |a| a.state }
node(:start) { |a| a.start_datetime}
node(:end) { |a| a.end_datetime}
node(:token) { |a| a.token }
