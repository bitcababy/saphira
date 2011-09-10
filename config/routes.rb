Saphira::Engine.routes.draw do
  resources :image_variants

  resources :file_items, :path => '/files', :id => /[^\\.]+/ do
    resources :image_variant_settings
  end

  root :to => 'file_items#index'
end
