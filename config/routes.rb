Bitchingserver::Application.routes.draw do

  resources :reports, :except => [:edit, :destroy]
  resources :municipalities, :only => [:index, :show]
  resources :report_images
end
