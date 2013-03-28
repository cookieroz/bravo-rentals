BravoRentals::Application.routes.draw do


  mount Ckeditor::Engine => '/ckeditor'
  resources :destinations
  resources :users
  resources :sessions
  resources :shared

  resources :messages, :only => [:new, :create]

  resources :rentals do
    collection { post :sort_photos }
    collection { post :search, to: 'rentals#index' }
  end

  match '/rentals/in/:destination_name-:destination_id-(:sleeps)-(:bedrooms)-(:start_date)-(:end_date)', to: 'rentals#filter', as: :filter_rentals

  get 'search', to: 'static_pages#search', as: 'search'
  get 'contact', to: 'static_pages#contact', as: 'contact'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  match '/admin', to: 'static_pages#admin'
  get 'owners', to: 'static_pages#owners', as: 'owners'
  get 'about', to: 'static_pages#about', as: 'about'

  resources :photos

  root :to => 'static_pages#home'

end
