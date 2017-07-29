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
    
