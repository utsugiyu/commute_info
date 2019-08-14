Rails.application.routes.draw do
  root 'infos#new'
  post '/create' => 'infos#create'
  get 'index' => 'infos#index'
  delete 'destroy' => 'infos#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
