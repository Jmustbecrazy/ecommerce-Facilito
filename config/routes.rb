Rails.application.routes.draw do
  devise_for :users
  #accion por url
  #get 'welcome/index'

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