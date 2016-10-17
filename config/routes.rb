Rails.application.routes.draw do

  namespace :api do
    post 'game/new' => 'games#new'
    post 'game/join' => 'games#join'
    post 'game/start' => 'games#start'
    get 'game/info' => 'games#info'
    get 'game/fetchall' => 'games#fetchall'
    post 'game/quit' => 'games#quit'
    post 'game/play' => 'games#play'
  end
  
  get '/' => 'static_pages#index'
  get '/game' => 'static_pages#index'
  root 'static_pages#index'
end
