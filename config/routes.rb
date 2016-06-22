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

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :account_subscriptions, only: :show, param: :user_id
    end
  end

end
