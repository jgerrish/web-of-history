require 'resque/server'

WebOfHistory::Application.routes.draw do
  mount Resque::Server.new, :at => "/resque"

  resources :shapefiles

  resources :historical_events do
    get :timeline, on: :collection
    get :map, on: :collection
  end

  resources :historical_sources

  get 'admin' => 'home#admin'

  root :to => "home#index"

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end
