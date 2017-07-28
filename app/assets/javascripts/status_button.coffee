$(document).ready ->
	console.log('TalkToMe is Ready!')
	status_button = $('#serverStatus')

	status_classes = { 
		'disconnected'  : 'is-danger',
		'connected' 	: 'is-primary',
		'ready' 		: 'is-success',
		'talking'		: 'is-warning',
		'waiting'		: 'is-info',
	}

	build_callback = (status, style) ->
		() ->
			status = status.charAt(0).toUpperCase() + status.slice(1);
			status_button.text status
			status_button.removeClass(Object.values(status_classes).join(' '))
			status_button.addClass style

	for status, style of status_classes
		status_button.bind status, build_callback(status, style) 




