Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'categories#root'
  get '/categories' => 'categories#index', as: :categories
  get '/categories/suggestions' => 'categories#suggestions', as: :suggestions_categories
  get '/categories/normalized' => 'categories#normalized', as: :normalized_categories
  get '/categories/:service' => 'categories#service', as: :service_categories
end
