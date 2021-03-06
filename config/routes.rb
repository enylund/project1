BiblioApp::Application.routes.draw do
  devise_for :users, :path_prefix => 'my', :skip => [:sessions]
  post "follow_channels/create"
  delete "follow_channels/destroy"

  resources :channels

  resources :comments

  resources :posts

  match "/users/:id" => "users#show", :via => :get, :as => :user
  # resources :users
  # map.user '/:username', :controller => 'users', :action => 'show'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".  # You can have the root of your site routed with "root"
   root "channels#index"

  as :user do
    get "login" => "devise/sessions#new", :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    match "logout" => "devise/sessions#destroy", :as => :destroy_user_session,
      :via => Devise.mappings[:user].sign_out_via
  end

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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
