class Product < ActiveRecord::Base
  #relacion con el modelo user
  belongs_to :user
  #validacion
  validates_presence_of :name, :user, :pricing
  validates :pricing, numericality: {greater_than: 0}
end
