Rails.application.routes.draw do
  root 'infos#new'
  post '/create' => 'infos#create'
  get '/index' => 'infos#index'
  delete '/infos/:id' => 'infos#destroy'
  post '/callback' => 'infos#callback'
  get '/infos/:id/edit' => 'infos#edit'
  patch "/infos/:id/edit"  => 'infos#update'
  get "/invalid-access"  => 'infos#access'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
