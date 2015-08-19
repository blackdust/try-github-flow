Rails.application.routes.draw do

  get "/lf" => "li_fei#index"

  get "/zjb" => "jian_bin#index"

  get "/szq" => "szq_shan#index"

  get "/sessions/new" => "sessions#new"
  post"/sessions/create"=> "sessions#create"
  
  resources :companies do
    resources :members
    resources :teams
  end
  
  # get "/identification/new"=>"identification#new"
  # post "/identification/create"=>"identification#create"
  # resources :identification
  # get "supply"=>"identification#supply"
  # post "/identification/supply"=>"identification#supply"
  # post "/identification/supply_success"=>"identification#supply_success"
  # get "supply_success"=>"identification#supply_success"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'szq_shan#index'

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
get '/libochao'=> "lbc#show"
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
