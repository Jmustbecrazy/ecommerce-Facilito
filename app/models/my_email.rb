class MyEmail < ActiveRecord::Base
	#lo que se quiere verificar en rspec se tiene que validar acá
	validates_presence_of :email
	validates_uniqueness_of :email
	#validar para que solo tenga formato email (devise)
	validates_format_of :email, with: Devise::email_regexp
	# /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
