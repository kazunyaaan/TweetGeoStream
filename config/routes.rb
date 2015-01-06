Rails.application.routes.draw do
  root 'stream#index'

  get 'stream/stream'
end
