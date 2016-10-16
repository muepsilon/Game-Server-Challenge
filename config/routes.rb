Rails.application.routes.draw do

  get 'static_pages/index'

  namespace :api do
    post 'game/new' => 'games#new'
    post 'game/join' => 'games#join'
    post 'game/start' => 'games#start'
    get 'game/info' => 'games#info'
    post 'game/play' => 'games#play'
  end
  
  get '/' => 'static_pages#index'
end
