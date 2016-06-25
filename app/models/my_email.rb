class MyEmail < ActiveRecord::Base
	#lo que se quiere verificar en rspec se tiene que validar acá
	validates_presence_of :email
	validates_uniqueness_of :email
end
