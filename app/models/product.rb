class Product < ActiveRecord::Base
  #relacion con el modelo user
  belongs_to :user
  
  #validacion
  validates_presence_of :name, :user, :pricing
  validates :pricing, numericality: {greater_than: 0}
  
  #validacion para que acepte imagenes (paperclip)
  has_attached_file :avatar, styles: { medium: "300x300", thumb: "100x100" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  #relacion con el modelo attachment
  has_many :attachment
end
