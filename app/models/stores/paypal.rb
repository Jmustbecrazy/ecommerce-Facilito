module Stores
	class Paypal
		include PayPal::SDK::REST
		#set y get
		attr_accessor :payment, :shopping_cart
		attr_accessor :return_url, :cancel_url

		def initialize(options)
			self.shopping_cart = options[:shopping_cart]
			self.return_url = options[:return_url]
			self.cancel_url = options[:cancel_url]
		end

		def process_payment
			# Build Payment object
			self.payment = Payment.new({
				:intent => "sale",
	    		:payer => {
	    			:payment_method => "paypal"
	    		},
	    		:transactions => [{
	    			:item_list => {
	    				:items => self.shopping_cart.items
	    			},
	    			:amount => {
	    				:total => self.shopping_cart.total / 100,
	    				:currency => "USD"
	    			},
	    			:description => "Compra de tus productos en nuestra plataforma"
	    		}],
	    		:redirect_urls => {
	    			:return_url => self.return_url,
	    			:cancel_url => self.cancel_url
	    			#:return_url => "http://localhost:3000/checkout",
	    			#:cancel_url => "http://localhost:3000/carrito"
	    		}
	    	})
	    	self.payment
		end


	end
end
#lo mismo que poner class Stores::Paypal