Rails.application.routes.draw do
  
  root 'crawler#crawl'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get 'articles/index', to: "articles#index"
end
