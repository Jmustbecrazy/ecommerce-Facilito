Rails.application.routes.draw do

  get 'links/download'

  get 'links/download_attachment'

  get 'links_controller/download'

  get 'links_controller/download_attachment'

  resources :attachments, only:[:create, :destroy, :new, :show]
  resources :products
  resources :in_shopping_carts, only:[:create, :destroy]
  devise_for :users
  #accion por url
  #get 'welcome/index'

  post '/emails/create', as: :create_email
  #link al apretar boton de paypal
  post '/pagar', to: 'payments#create'
  #ruta para el pago con tarjeta
  post 'payments/cards', to: 'payments#process_card'

  #ruta para carrito
  get '/carrito', to: 'shopping_carts#show'
  get '/add/:product_id', as: :add_to_cart, to: 'in_shopping_carts#create'
  get '/checkout', to: 'payments#checkout'

  #rutas para descargas
  get "/descargar/:id", to:"links#download"
  get "/descargar/:id/archivo/:attachment_id", to:"links#download_attachment", as: :download_attachment
  get "/invalid", to: "welcome#unregistered"

  #ruta creada comenzando el tutorial de reiniciar carrito
  get '/ok', to: 'welcome#payment_succed'

  get "/ordenes", to: "ordenes#index"

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