Rails.application.routes.draw do
  resources :messages
  resources :rooms
  # get  '/rooms/:id' => 'rooms#show'
  root 'rooms#index'

  get '/api/rooms' => 'api#get_rooms'
  post '/api/rooms' => 'api#create_room'
  get '/api/room/:id/messages' => 'api#get_messages'
  post '/api/room/:id/messages' => 'api#create_message'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
