#evento ajax cuando ponemos un correo y damos enter
$(document).on "ajax:beforeSend", "#emails-form", ()->
	console.log "se esta enviando formulario"
	$("#email-info").html "Se esta procesando tu petición..."
		.show(2000)

#evento ajax exitoso
$(document).on "ajax:success", "#emails-form", (e, data, state, xhr)->
	$(this).slideUp()
	$("#email-info").html "Ya estás en la fila de las invitaciones beta!!"

#evento ajax cuando hay un error
$(document).on "ajax:error", "#emails-form", (e, data, state, xhr)->
	console.log data
	$("#email-info").html data.responseJSON.email[0]