Rails.application.routes.draw do
  #root to: "sessions#new"

  #get "/api", to: "static_pages#root"

  root to: "static_pages#root"

  #TODO limit to used actions
  resources :users
  resource :session
#   resources :albums do
#     resource :share, only: [:new, :create]
#     collection do
#       get 'public'
#     end
#     resources :photos, only: [:new, :create] #rename route this to /albums/:id/upload
#   end
#
#   resources :photos, only: [:show, :edit, :update, :destroy, :index] do
#     resources :comments, only: [:create]
#     resource :likes, only: [:create, :destroy]
#   end
#
#   resources :tags, only: [:index, :show, :destroy]
#
#   resources :comments, only: [:destroy] # maybe add edit with js
#
  resources :notifications, only: [:index, :show]

  get 'auth/google_oauth2/callback', to: "sessions#google"


  namespace :api, defaults: {format: 'json'} do
    resources :users, only: [:show]
    resources :photos, only: [:show, :update, :destroy, :index, :create] do
      resources :comments, only: [:index]
      resource :likes, only: [:create, :destroy] # maybe add index of photos you like
    end
    resources :comments, only: [:destroy, :show, :create, :destroy] # maybe add edit with js

    resources :albums do
      resource :share, only: [:create]
      collection do
        get 'public'
      end
    end

    resources :tags, only: [:index, :show, :destroy]

    resources :notifications, only: [:index, :show, :update]
  end



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
