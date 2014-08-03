require 'resque/server'

WebOfHistory::Application.routes.draw do

  resources :event_groups do
    get :map, on: :member
  end

  resources :maps

  resources :historical_locations do
    get :map, on: :collection
  end

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
