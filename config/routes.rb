Youtubueidcheck::Application.routes.draw do
  resources :youtube_ids, :only => [:index, :new, :create, :destroy] 

  root :to => 'youtube_ids#index'
end
