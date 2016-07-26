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
	# relacion 1 - * con MyPayments
	has_many :my_payments

	aasm column: "status" do
		state :incomplete, :initial => true
		state :payed, :failed
		#evento
		event :pay do
			after do
				self.generate_links()
				#mandar los archivos que el usuario compro
			end
			transitions :from => :incomplete, :to => :payed
    	end
	end

	def payment
		begin
			my_payments.payed.first
			#excepcion en caso no haya nada
		rescue Exception => e
			return nil
		end

	end

	def generate_links
		self.products.each do |product|
			Link.create(expiration_date: DateTime.now + 7.days, product: product, email: payment.email)
		end
	end

	def items
		self.products.map { |product| product.paypal_form }
	end

	def total
		#manera eficiente
		products.sum(:pricing)		
	end
end
