Rails.application.routes.draw do
  resources :attachments, only:[:create, :destroy, :new, :show]
  resources :products
  resources :in_shopping_carts, only:[:create, :destroy]
  devise_for :users
  #accion por url
  #get 'welcome/index'

  post '/emails/create', as: :create_email
  #ruta para carrito
  get '/carrito', to: 'shopping_carts#show'
  get '/add/:product_id', as: :add_to_cart, to: 'in_shopping_carts#create'

  #si el usuario esta autenticado
  authenticated :user do
    #manda al controlador welcomer la vista index
    root 'welcome#index'
  end

  #si no esta autenticado
  unauthenticated :user do
    #scope
    devise_scope :user do
      #manda al controlador la vista de unregistered
      root 'welcome#unregistered', as: :unregistered_root
    end
  end

end