Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}

  # namespace :api, path: "", constraints: ApiDomain.new do
  #   namespace :v1 do
  #     resources :users, only: [:index]
  #   end
  # end


  #scope path: "/api/v1/"
  # scope path:'/api/v1/',constraints: ApiDomain.new, :module => "api_v1", :as => 'v1', :defaults => { :format => :json } do
  # resources :topics
  # end

  #原先domain的api
  scope path:'/api/v1/', :module => "api_v1", :as => 'v1', :defaults => { :format => :json } do
  resources :topics
  end


    root "topics#index"
  get '/test',to: "topics#test"

  namespace :admin do
    resources :users do
      member do
        post :to_admin
        post :to_normal
      end
    end
  end

  resources :users do
    collection do
      get :profile
      put :edit_profile
      get :post_topics
      get :post_comments
      get :like_topics
      get :stored_topics

    end
  end

  resources :categories

  resources :topics do
    collection do
      get :about
      get :last_time
      get :comment_count

    end

    member do
      post :like
      post :unlike
      post :comment
      post :del_comment
      post :store
      post :unstore

    end

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
