Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "apartments#index"
  resources :apartments do
    resources :deeds, only: [:new, :create]
  end

  resources :appointments, only: %i[index create update] do
    post :visited
  end

  get 'my_apartments', to: 'apartments#my_apartments'
  get 'rent_apartment', to: 'apartments#rent_apartment'
  devise_for :users
end
