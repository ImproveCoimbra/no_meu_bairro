Bitchingserver::Application.routes.draw do
  resources :reports, :except => [:destroy] do
    put :extend, :on => :member
    get :comment_added, :on => :member
    get :stats, :on => :collection
  end
  resources :municipalities, :only => [:index, :show]
  get 'about' => 'front#about'
  get 'faq' => 'front#faq'
  root :to => 'front#index'
end
