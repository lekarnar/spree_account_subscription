Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :account_subscriptions

    resources :products

    resources :users do
      member do
        get :account_subscriptions
      end
    end
  end
end
