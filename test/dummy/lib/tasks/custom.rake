namespace :db do
  task :migrate => [:'saphira:install:migrations']
end