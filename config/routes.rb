Rails.application.routes.draw do
  resources :pages
  resources :sprints
  #The /user_scrums must appear over the resources :daily_scrums, because otherwise
  #the :daily_scrums/:id route will pick it up.
  get 'daily_scrums/user_scrums' => 'daily_scrums#user_scrums'
  post 'daily_scrums/search_user_scrums' => 'daily_scrums#search_user_scrums'
  get 'daily_scrums/all_scrums' => 'daily_scrums#all_scrums'
  get 'daily_scrums/:sprint_id/search_all_scrums' => 'daily_scrums#search_all_scrums', :as => 'search_all_scrums_by_sprint'
  post 'daily_scrums/search_all_scrums' => 'daily_scrums#search_all_scrums'
  resources :daily_scrums
  devise_for :users
  root 'pages#index'
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
