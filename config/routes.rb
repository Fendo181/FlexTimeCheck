Rails.application.routes.draw do
  get 'home' => 'users#home'
  post 'check' => 'users#check'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
