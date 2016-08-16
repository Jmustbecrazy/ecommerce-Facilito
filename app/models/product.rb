# == Schema Information
#
# Table name: products
#
#  id                  :integer          not null, primary key
#  name                :string
#  pricing             :integer
#  description         :text
#  user_id             :integer
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#


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

  #relacion muchos a muchos con shoping_cart
  has_one :shopping_cart, through: :in_shopping_carts
  has_many :in_shopping_carts

  has_many :my_payments, through: :shopping_cart


  def paypal_form
    {
      :name => name,
      :sku => :item,
      :price => (pricing / 100),
      :currency => "USD",
      :quantity => 1
    }
  end

  def sales
    my_payments.payed    
  end

end
