class LinkMailer < ActionMailer::Base
	default from: "downloads@hotmail.com"

	def download_link(link)
		#metodo propio del ActionMailer de rails
		@link = link 
		@product = link.product
		mail(to: link.email, subject: "Descarga los productos que adquiriste")
	end	
end