Rails.application.routes.draw do
  resources :attachments, only:[:create, :destroy, :new, :show]
  #get 'attachments/create'

  #get 'attachments/destroy'

  #get 'attachments/new'

  resources :products
  devise_for :users
  #accion por url
  #get 'welcome/index'

  post '/emails/create', as: :create_email


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