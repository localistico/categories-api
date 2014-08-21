Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :categories do
    collection do
      get :suggestions
      get :normalized
    end
  end
end
