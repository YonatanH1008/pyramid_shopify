Rails.application.routes.draw do
  devise_for :users, path_prefix: "devise", controllers: { registrations: "registrations" }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        get "standins" => "users#standings", as: "standings"
        post "login" => "sessions#create", as: "login"
        post "invite" => "users#invite", as: "invite"
        post "get_lucky" => "users#get_lucky", as: "get_lucky"
        delete "logout" => "sessions#destroy", as: "logout"
        put "password/update", to: "registrations#update_password"
      end

      resources :users, only: [:show, :create, :update, :destroy], constraints: { id: /.*/ }
      resources :notes, only: [:index, :create] do
        collection do
          post 'bulk_delete'
        end
      end
    end
  end

  root "home#index"
  get '*path', to: 'home#index', via: :all
end
