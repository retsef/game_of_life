Rails.application.routes.draw do
  devise_for :users,
             path: 'auth',
             controllers: {
               sessions: 'auth/sessions',
               registrations: 'auth/registrations',
               passwords: 'auth/passwords'
             }
end
