Rails.application.routes.draw do
  root 'users#index'
  post 'check' => 'users#check'
  #redirect
  get  "check", to: "users#index"
end
