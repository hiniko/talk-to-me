$(document).ready ->
    voice_select = $('#voice-select')
    voice_message = $('#voice-message')
    voice_send   = $('#voice-send')
    
    # Make the form focused on page start
    voice_message.focus()

    message_log = []
    message_index = 0

    # Get a message from the sent log if available. Ensure indexs are limited
    get_log = (direction) ->
        return "" if message_log.length == 0
        msg = message_log[message_index]
        switch direction
            when "up"
                message_index++
            when "down"
                message_index--
        message_index = message_log.length - 1 if message_index >= message_log.length
        message_index = 0 if message_index < 0
        return msg

    # Set voice options on options event
    voice_select.on 'options', (event, data) ->
        data = data.filter (obj) ->
            return obj if obj.locale.match("en")
        for obj in data
            voice_select.append("<option value=#{obj.voice}>#{obj.voice}</option>")

    # Send message function 
    send_message =  (voice, message) ->
            App.messages.send({"voice": voice, "msg": message})
            voice_message.val('')
            message_log.push message unless message_log.includes message

    # Setup form keyboard controls
    voice_message.on 'keydown', (event) ->
        switch event.key
            when "Enter"
                if voice_message.val() != ''
                    send_message(voice_select.val(), voice_message.val())
                    message_index = 0
                    voice_message.attr('placeholder', '')
            when "ArrowUp"
                voice_message.attr('placeholder', get_log("up") )
            when "ArrowDown"
                voice_message.attr('placeholder', get_log("down") )
            when "ArrowRight"
                voice_message.val(voice_message.attr('placeholder'))

    # Setup talk button to send messages
    voice_send.on 'click', (event) ->
        send_message(voice_select.val(), voice_message.val())
        
         
