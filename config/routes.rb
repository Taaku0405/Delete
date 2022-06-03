Rails.application.routes.draw do
  devise_for :end_users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

   namespace :admin do
     resources :end_users, only: [:index, :show, :edit, :update]

     resources :genres, only: [:index, :create, :edit, :update]

     resources :posts, except: [:create]

     get "search" => "searches#search"
  end

    scope module: :public do
     resources :end_users, only: [:index, :show, :edit, :update ]
     get "end_users/unsubscribe", as: "unsubscribe"
     patch "end_users/withdraw", as: "withdraw"

     resources :posts do
       resources :post_comments, only: [:create, :destroy]
       resource :favorites, only: [:create, :destroy]
     end

     resources :groups, except: [:destroy]
      get 'search' => 'searches#search'
   end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end