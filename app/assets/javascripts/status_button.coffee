$(document).ready ->
	console.log('TalkToMe is Ready!')
	status_button = $('#serverStatus')

	status_classes = [
		'is-success',
		'is-primary',
		'is-danger',
		'is-info',
		'is-warning'
	]

	status_button.bind 'connected', => 
		status_button.text "Connected"
		status_button.removeClass(status_classes.join(' '))
		status_button.addClass "is-primary"

	status_button.bind 'disconnected', =>
		status_button.text "Disconnected"
		status_button.removeClass(status_classes.join(' '))
		status_button.addClass "is-danger"

	
