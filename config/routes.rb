Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :items do
        get '/:id/merchant', to: 'merchants#show'
      end

      namespace :merchants do
        get '/:id/items', to: 'items#index'
      end

      resources :merchants, except: [:new, :edit]
      resources :items, except: [:new, :edit]
    end
  end
end
