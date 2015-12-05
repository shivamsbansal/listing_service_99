Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/' => 'api_listings#index'
      post '/' => 'api_listings#create'
      get '/:id/' => 'api_listings#show'
      put '/:id/' => 'api_listings#update'
      delete '/:id' => 'api_listings#delete'
    end
  end
end
