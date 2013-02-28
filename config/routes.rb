Bitchingserver::Application.routes.draw do
  resources :reports, :except => [:destroy]
  resources :municipalities, :only => [:index, :show]
  root :to => 'front#index'
end
