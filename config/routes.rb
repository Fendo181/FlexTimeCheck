Rails.application.routes.draw do
  get 'time_check_pages/home'
  get 'time_check_pages/help'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
