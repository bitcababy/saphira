Saphira::Engine.routes.draw do
  resources :file_items, :path => '/files', :id => /[^\\.]+/

  root :to => 'file_items#index'
end
