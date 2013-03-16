Bitchingserver::Application.routes.draw do
  resources :reports, :except => [:destroy] do
    put :extend, :on => :member
  end
  resources :municipalities, :only => [:index, :show]
  root :to => 'front#index'
end
