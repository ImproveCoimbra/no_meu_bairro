Bitchingserver::Application.routes.draw do
  resources :reports, :except => [:destroy] do
    put :extend, :on => :member
    get :comment_added, :on => :member
  end
  resources :municipalities, :only => [:index, :show]
  match 'about' => 'front#about'
  match 'faq' => 'front#faq'
  root :to => 'front#index'
end
