class PaymentsController < ApplicationController
  include PayPal::SDK::REST

  def checkout
  	@my_payment = MyPayment.find_by(paypal_id: params[:paymentId])
  	#validacion
  	if @my_payment.nil?
  		redirect_to "/carrito"
  	else
  		payment = Payment.find(@my_payment.paypal_id)
  		if payment.execute(:payer_id => params[:PayerID])
  			#mensaje de cobro exitoso
  			redirect_to carrito_path, notice: "Se proceso el pago con Paypal"
  		else
  			redirect_to carrito_path, notice: "Hubo un error, intentelo luego!"
  		end
  	end
  end

  def create
  	# Build Payment object
	payment = Payment.new({
		:intent => "sale",
  		:payer => {
  			:payment_method => "paypal"
  		},
  		:transactions => [
  			{
  				:item_list => {
  					:items => [{
  						:name => "Demo",
  						:sku => :item,
  						:price => (@shopping_cart.total / 100),
  						:currency => "USD",
  						:quantity => 1
  						}]
  				},
  				:amount => {
  					:total => @shopping_cart.total / 100,
  					:currency => "USD"
  				},
  				:description => "Compra de tus productos en nuestra plataforma"
  			}
  		],
  		:redirect_urls => {
  			:return_url => "http://localhost:3000/checkout",
  			:cancel_url => "http://localhost:3000/carrito"
  		}
  	})

	# Create Payment and return the status(true or false)
	if payment.create
		#Payment Id
		#@payment.id
		@my_payment = MyPayment.create!(paypal_id: payment.id, ip: request.remote_ip, shopping_cart_id: cookies[:shopping_cart_id])
		redirect_to payment.links.find{|v| v.method == "REDIRECT" }.href
	else
		#Error Hash
		#@payment.error
		raise payment.error.to_yaml
	end
  end

end
