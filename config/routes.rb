Rails.application.routes.draw do
  resources :board_games, except:[:index]
  get '/', to: 'board_games#index', as: 'home'
  get '/search', to: 'board_games#search', as: 'search'
end
