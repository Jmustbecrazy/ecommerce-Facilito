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
			#creamos el objeto payment de la gema paypal
			self.payment = Payment.new(payment_options)
	    	self.payment
		end

		def process_card(card_data)
			options = payment_options
			options[:payer][:payment_method] = "credit_card"
			options[:payer][:funding_instruments] = [{
				:credit_card => {
					:type => CreditCardValidator::Validator.card_type(card_data[:number]),
					:number => card_data[:number],
					:expire_month => card_data[:expire_month],
					:expire_year => card_data[:expire_year],
					:cvv2 => card_data[:cvv2]
				}
			}]
			#creamos el objeto payment de la gema paypal
			self.payment = Payment.new(options)
	    	self.payment
		end

		def payment_options
			{
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
	    	}
		end

		def self.get_email(payment_id)
			#para sacar el correo
        	payment = Payment.find(payment_id)
        	#retornamos el email con metodos de paypal
        	payment.payer.payer_info.email
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