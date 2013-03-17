BravoRentals::Application.routes.draw do


  mount Ckeditor::Engine => '/ckeditor'
  resources :destinations
  resources :users
  resources :sessions
  resources :shared

  resources :messages, :only => [:new, :create]

  resources :rentals do
    collection { post :sort_photos }
    # collection { post :search, to: 'villas#index' }
  end

  get "static_pages/about"

  get 'search', to: 'static_pages#search', as: 'search'
  get 'contact', to: 'static_pages#contact', as: 'contact'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  match '/admin', to: 'static_pages#admin'

  resources :photos

  root :to => 'static_pages#home'

end
