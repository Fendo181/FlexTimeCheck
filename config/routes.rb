Rails.application.routes.draw do
  root 'users#home'
  post 'check' => 'users#check'
  #redirect
  get  "check", to: "users#home"
end
