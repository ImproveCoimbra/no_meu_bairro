Bitchingserver::Application.routes.draw do
  resources :reports, :except => [:destroy] do
    put :extend, :on => :member
  end
  resources :municipalities, :only => [:index, :show]
  match 'about' => 'front#about'
  root :to => 'front#index'
end
