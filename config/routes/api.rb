namespace :api, defaults: { format: 'json' } do
  namespace :v1 do
    resources :repositories, only: :index
  end
end