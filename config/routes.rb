Rails.application.routes.draw do
  resources :categories do
    collection do
      get :suggestions
      get :normalized
    end
  end
end
