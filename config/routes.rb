# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'games#new'
  get 'new', to: 'games#new'
  post 'score', to: 'games#score'
  post 'grand_score', to: 'games#grand_score'
  get 'reset_session', to: 'games#reset'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
