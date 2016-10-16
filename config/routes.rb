Rails.application.routes.draw do

  namespace :api do
    post 'game/new' => 'games#new'
    post 'game/join' => 'games#join'
    post 'game/start' => 'games#start'
    get 'game/info' => 'games#info'
    post 'game/play' => 'games#play'
  end
  
  get '*path' => 'static_pages#index'
  root 'static_pages#index'
end
