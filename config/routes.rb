Rails.application.routes.draw do
  get 'users/home'
  get 'users/help'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
