Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'categories#root'
  resources :categories do
    collection do
      get :suggestions
      get :normalized
    end
  end
end
