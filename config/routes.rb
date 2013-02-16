Bitchingserver::Application.routes.draw do
  resources :reports, :except => [:edit, :update, :destroy]
  resources :municipalities, :only => [:index, :show]
  root :to => 'reports#index'
end
