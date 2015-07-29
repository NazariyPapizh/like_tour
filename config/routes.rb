Rails.application.routes.draw do
  devise_for :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # authenticate :user do
  #   scope "/admin" do
  #     get 'translate' => 'translate#index', :as => :my_translate_list
  #     post 'translate' => 'translate#translate', :as => :my_translate
  #     get 'translate/reload' => 'translate#reload', :as => :my_translate_reload
  #   end
  # end



  get "/get_cities_from_category" => "catalog#get_cities", :as => 'get_cities'
  get "/get_filters_from_category_c" => "catalog#get_filters_from_category", :as => 'get_filter_words_c'
  get "/get_filters_from_category" => "catalog#get_filter_words", :as => 'get_filter_words'


  # You can have the root of your site routed with "root"
  scope "(:locale)", :locale => /#{I18n.available_locales.join('|')}/ do

    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    mount Ckeditor::Engine => '/ckeditor'


    root 'main#index'
    post '/order_event' => 'catalog#order_event', as: 'order_event'
    post '/feedback_form' => 'catalog#feedback', as: 'feedback'

    get 'about_us' => 'static_page#about'
    get 'service' => 'service#all', as: 'services'
    get 'service/:name' => 'service#show', as: 'service'
    get 'publication' => 'static_page#publication'
    get 'publication/:url' => 'static_page#one_publication', as: 'one_publication'
    get 'contacts' => 'static_page#contacts'

    get 'events/:category_name' => 'catalog#category', as: 'category'
    get 'events/:category_name/:city_name(?flags=:flags)' => 'catalog#category_with_city', as: 'category_with_city'
    get 'events/:category_name/:city_name/:tour_name' => 'catalog#tour', as: 'tour'

    get 'privacy' => 'main#privacy', as: 'privacy'
    get 'sitemap' => 'main#saitmap', as: 'sitemap'
    get 'test' => 'static_page#test_page'
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
  match '*a', :to => 'errors#routing', via: :get
end
