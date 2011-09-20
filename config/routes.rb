Saphira::Engine.routes.draw do
  resources :image_variants
  resources :file_items, :path => '/files', :id => /[^\\.]+/ do
    get 'upload_files', :on => :collection, :as => 'upload'
    resources :image_variant_settings
  end

  root :to => 'file_items#index'
end
