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
        @my_payment.pay!
  			redirect_to carrito_path, notice: "Se proceso el pago con Paypal"
  		else
  			redirect_to carrito_path, notice: "Hubo un error, intentelo luego!"
  		end
  	end
  end

  def create
    paypal_helper = Stores::Paypal.new(shopping_cart: @shopping_cart, return_url: checkout_url, cancel_url: carrito_url)
  	# Create Payment and return the status(true or false)
  	if paypal_helper.process_payment.create
  		@my_payment = MyPayment.create!(paypal_id: paypal_helper.payment.id, ip: request.remote_ip, shopping_cart_id: cookies[:shopping_cart_id])
  		redirect_to paypal_helper.payment.links.find{|v| v.method == "REDIRECT" }.href
  	else
  		#Error
  		raise paypal_helper.payment.error.to_yaml
  	end
  end

end
