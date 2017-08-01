$(document).ready ->
  App.options = App.cable.subscriptions.create { channel: "TalkChannel", type: 'options' },
    connected: ->
      console.log "Connected to options stream of TalkChannel"
      @perform('options')
    disconnected: ->
      console.log "disconnected from options stream of TalkChannel"
    received: (data) ->
      console.log "recieved voices update"
      $('#voice-select').trigger('options', [data])

  App.messages = App.cable.subscriptions.create { channel: "TalkChannel", type: 'messages' },
    connected: ->
      console.log "Connected to messages stream of TalkChannel"
    disconnected: ->
      console.log "disconnected from messages stream of TalkChannel"
    received: (data) ->
      console.log data
