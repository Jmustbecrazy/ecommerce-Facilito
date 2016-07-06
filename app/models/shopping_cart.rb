# == Schema Information
#
# Table name: shopping_carts
#
#  id         :integer          not null, primary key
#  status     :string
#  ip         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShoppingCart < ActiveRecord::Base
	include AASM
	has_many :products, through: :in_shopping_carts
	has_many :in_shopping_carts
	#si status = 0 -> no esta pagado
	#si status = 1 -> esta pagado
	#enum status: {payed: 1, default: 0}

	aasm column: "status" do
		state :incomplete, :initial => true
		state :payed, :failed
		#evento
		event :pay do
			after do
				#mandar los archivos que el usuario compro
			end
			transitions :from => :incomplete, :to => :payed
    	end
	end

	#metodo que sacara el total
	def totaless
		#manera ineficiente
		suma = 0
		products.each do |product|
			suma += product.pricing
		end
		suma
	end

	def items
		self.products.map { |product| product.paypal_form }
	end

	def total
		#manera eficiente
		products.sum(:pricing)		
	end
end
