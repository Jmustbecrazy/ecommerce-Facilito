module Stores
	class Paypal
		include PayPal::SDK::REST
		#set y get
		attr_accessor :payment, :total, :items
		attr_accessor :return_url, :cancel_url

		def initialize(options)
			self.total = options[:total]
			self.items = options[:items]
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
	    				:items => self.items
	    			},
	    			:amount => {
	    				:total => self.total/100,
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

		def self.checkout(payer_id, payment_id, &block)
			payment = Payment.find(payment_id)
			if payment.execute(payer_id: payer_id)
				yield if block_given?							
			end			
		end


	end
end
#lo mismo que poner class Stores::Paypal