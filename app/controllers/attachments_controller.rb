class AttachmentsController < ApplicationController
  #debe tener un inicio de sesión
  before_action :authenticate_user!
  #para el error que salia al eliminar archivo
  before_action :set_attachment, only: [:destroy, :show]
  before_action :set_product, only: [:destroy]
  #debe ser el propietario
  before_action :authenticate_owner!, except: :show

  def show
    #para poder descargar archivo
    send_file @attachment.file.path
  end

  def new
  end

  def create
  	@attachment = Attachment.new(attachment_params)
  	if @attachment.save
  		redirect_to @attachment.product, notice: "Se guardo el archivo adjunto"
  	else
  		redirect_to @product, notice: "no pudimos agregar archivo"
  	end
  end

  def destroy
  	@attachment.destroy
  	redirect_to @product
  end

  private
  def set_attachment
  	@attachment = Attachment.find(params[:id])
  end

  def set_product
  	@product = @attachment.product
  end

  def authenticate_owner!
  	if params.has_key? :attachment
  		@product = Product.find(params[:attachment][:product_id])
  	end

  	if @product.nil? || @product.user != current_user
  		redirect_to root_path, notice: "No puede editar ese producto"
  		return
  	end

  end

  def attachment_params
  	params.require(:attachment).permit(:product_id, :file)
  end

end
