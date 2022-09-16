Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  draw :auth

  resources :simulations, except: %i[edit update] do
    patch :start, on: :member
    patch :pause, on: :member

    resources :generations, only: %i[index show]
  end

  # Defines the root path route ("/")
  # root controller: 'auth/user_sessions', action: :new
  root controller: :simulations, action: :new

  draw :errors
end
