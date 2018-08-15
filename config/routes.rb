# frozen_string_literal: true

Rails.application.routes.draw do
  VALID_EMAIL_REGEX = /[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*/
  resources :queries, constraints: { id: VALID_EMAIL_REGEX } , only: [] do
     resource :progress, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
