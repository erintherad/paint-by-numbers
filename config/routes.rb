Rails.application.routes.draw do

  root "pages#home"

  resources :users, except: [:destroy]
   # users routes
  get "/signup", to: "users#new"
  get "/profile", to: "users#show"
  # get '/users/edit', to: "users#edit"

  get "/about", to: "pages#about"

  # sessions routes
  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy"
  # post "/sessions", to: "sessions#create"
  resources :sessions

  get "/create", to: "paintings#new"
  get "/gallery", to: "pages#gallery", as: 'gallery'

  post '/render-svg', to: 'svg#create'

  resources :paintings
end

#        Prefix Verb   URI Pattern                   Controller#Action
#          root GET    /                             pages#home
#         users GET    /users(.:format)              users#index
#               POST   /users(.:format)              users#create
#      new_user GET    /users/new(.:format)          users#new
#     edit_user GET    /users/:id/edit(.:format)     users#edit
#          user GET    /users/:id(.:format)          users#show
#               PATCH  /users/:id(.:format)          users#update
#               PUT    /users/:id(.:format)          users#update
#        signup GET    /signup(.:format)             users#new
#       profile GET    /profile(.:format)            users#show
#         about GET    /about(.:format)              pages#about
#       gallery GET    /gallery(.:format)            paintings#show
#         login GET    /login(.:format)              sessions#new
#        logout GET    /logout(.:format)             sessions#destroy
#      sessions GET    /sessions(.:format)           sessions#index
#               POST   /sessions(.:format)           sessions#create
#   new_session GET    /sessions/new(.:format)       sessions#new
#  edit_session GET    /sessions/:id/edit(.:format)  sessions#edit
#       session GET    /sessions/:id(.:format)       sessions#show
#               PATCH  /sessions/:id(.:format)       sessions#update
#               PUT    /sessions/:id(.:format)       sessions#update
#               DELETE /sessions/:id(.:format)       sessions#destroy
#     paintings GET    /paintings(.:format)          paintings#index
#               POST   /paintings(.:format)          paintings#create
#  new_painting GET    /paintings/new(.:format)      paintings#new
# edit_painting GET    /paintings/:id/edit(.:format) paintings#edit
#      painting GET    /paintings/:id(.:format)      paintings#show
#               PATCH  /paintings/:id(.:format)      paintings#update
#               PUT    /paintings/:id(.:format)      paintings#update
#               DELETE /paintings/:id(.:format)      paintings#destroy
              