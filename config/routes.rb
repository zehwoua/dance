DanceDynamics::Application.routes.draw do

  devise_for :users, :controllers => { 
    :registrations => "users/registrations" ,
    :omniauth_callbacks => "omniauth_callbacks"
  }
  devise_scope :user do
    get '/sign_in' => 'sessions#new'
    get "/sign_up", :to => "registrations#new"
  end

  devise_for :users do
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  
  mount Monologue::Engine, at: '/blog'

 
 # get "favorite_videos/destroy"
  get "home/index"
  get "/dashboard" => "users#dashboard", :as => :user_dashboard
  get "/dashboard/profile" => "users#profile", :as => :user_profile
  get "/dashboard/my_classes"  => "users#my_classes", :as => :user_my_classes
  get "users/billing"
  put "users/update_avatar"
  get "users/edit_payment_info"
  get "users/confirm_payment_info"
  get "/register" => "users#new_membership", :as => :new_membership
  post "/payment" => "users#create_membership", :as => :create_membership
  get "users/new_subscription_method"
  get "home/subscription"
  
  resources :styles, :levels, :favorite_videos, :history_videos, :teachers
  resources :favorite_teachers, :only => [:create, :destroy]
  resources :users do
    resources :addresses
    resources :credit_cards
    resources :subscriptions
     post "credit_cards/make_default"
  end
  
  namespace :admin do
    root :to => "admin#index"
    get "/plans" => "admin#plans", :as => :admin_plans do 
      resources :subscriptions
    end
    resources :users
    get "new_admin" => "users#new_admin", :as => :new_admin
    post "create_admin" => "users#create_admin", :as => :create_admin
    get "edit_admin/:id" => "users#edit_admin", :as => :edit_admin
    put "update_admin/:id" => "users#update_admin", :as => :update_admin
    get "new_customer" => "users#new_customer", :as => :new_customer
    post "create_customer" => "users#create_customer", :as => :create_customer
    get "edit_customer/:id" => "users#edit_customer", :as => :edit_customer
    put "update_customer/:id" => "users#update_customer", :as => :update_customer
    resources :videos, :except => [:index]
    resources :today_videos
    get "videos" => "videos#index_admin", :as => :admin_videos
    resources :levels
    resources :styles
    resources :teachers
    resources :users
    resources :comments
    put "/approve_comments" => "comments#approve_comments", :as => :approve_comments
  end
  resources :credit_card_info, :only => [:edit]

  resources :videos do
    resources :comments
  end

  match 'users/confirm_payment_info' => 'users#confirm_payment_info', :as => :confirm_payment_info
  match 'dashboard/billing', :to => 'users#billing'
  match 'credit_card_info/confirm' => 'credit_card_info#confirm', :as => :confirm_credit_card_info
  match 'subscription', :to => 'home#subscription'
  # post "/favorite_teachers" => "favorite_teachers#create", :as => :add_favorite_teacher


  # match 'users/:id' => 'dashboard'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
