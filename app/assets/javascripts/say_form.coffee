$(document).ready ->
    voice_select = $('#voice-select')
    voice_message = $('#voice-message')
    voice_send   = $('#voice-send')

    voice_message.focus()

    # Set voice options on options event
    voice_select.on 'options', (event, data) ->
        data = data.filter (obj) ->
            return obj if obj.locale.match("en")
        for obj in data
            voice_select.append("<option value=#{obj.voice}>#{obj.voice}</option>")

    # Setup input to sent meessages 
    send_message =  (voice, message) ->
            App.messages.send({"voice": voice, "msg": message})
            voice_message.val('')

    voice_message.on 'keydown', (event) ->
        if event.which  == 13
            send_message(voice_select.val(), voice_message.val())
            
    voice_send.on 'click', (event) ->
        send_message(voice_select.val(), voice_message.val())
        
         
