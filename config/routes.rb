ActionController::Routing::Routes.draw do |map|
  #map.devise_for :user
  
  map.resources :configurations, :collection => { :merge_defaults => :get }
  map.resources :wallets
  map.resources :plays

  map.resources :currency_accounts, :member => {
    :play => :get,
    :record_play => :post
  }
  map.play_history 'currency_accounts/:id/history/:play_name', :controller => 'currency_accounts', :action => 'history'
  map.history 'currency_accounts/:id/history', :controller => 'currency_accounts', :action => 'history'
  
  map.my_currencies('/my_currencies', :controller => 'currency_accounts', :action => 'my_currencies')
  map.dashboard('/dashboard', :controller => 'currency_accounts', :action => 'dashboard')
  map.dashboard_activity('/dashboard/activity', :controller => 'currency_accounts', :action => 'dashboard_activity')
  map.join_currency('/my_currencies/join', :controller => 'currency_accounts', :action => 'join_currency', :conditions => { :method => :get })
  map.connect('/my_currencies/join', :controller => 'currency_accounts', :action => 'join', :conditions => { :method => :post })

  map.resources :activities

  map.resources :proposals

  map.resources :currencies, :member => {
    :player_classes => :get
  }

  map.resources :circles, :member => {
    :players => :get, :set_players => :put,
    :link_players => :get, :set_link_players => :put,
    :currencies => :get, :set_currencies => :put
    },
    :collection => { :members => :get}

  map.resources :weals
  map.resources :weals, :member => {
    :set_mate => :put
    }

  map.resources :intentions, :controller => "weals",
    :member => {:phaseshift => :put},
    :collection => { :my => :get, :proposed => :get}
  map.resources :actions, :controller => "weals",
    :member => {:phaseshift => :put},
    :collection => { :my => :get }
  map.resources :assets, :controller => "weals",
    :collection => { :my => :get }

  # The priority is based upon order of creation: first created -> highest priority.

  map.admin('/admin', :controller => 'home', :action => 'admin')
  map.sys_info('/sys_info', :controller => 'home', :action => 'sys_info')

  map.logged_out('/logged_out', :controller => 'home', :action => 'logged_out')

#  map.from_plugin(:bolt)
  map.logged_in_users '/users/logged_in', :controller => 'users', :action => 'logged_in_users'
  map.signup_users '/users/signup', :controller => 'users', :action => 'signup', :conditions => { :method => :get }
  map.signup_users '/users/signup', :controller => 'users', :action => 'do_signup', :conditions => { :method => :post }
  map.resources :users, :member => {
    :login_as => :get,
    :permissions => :get, :set_permissions => :put,
    :preferences => :get, :set_preferences => :put,
    :contact_info => :get, :set_contact_info => :put,
    :email => :get, :process_email => :put
    }


  map.home('', :controller => 'home', :action => 'home')
  map.version('/version', :controller => 'home', :action => 'version')
  
  map.close_banner('/close_banner', :controller=> 'home', :action => 'close_banner')
  

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
