$(document).ready ->
  App.status = App.cable.subscriptions.create { channel: "StatusChannel" },
    connected: ->
      $('#serverStatus').trigger('connected')
      console.log "Connected to StatusChannel"
    disconnected: ->
      $('#serverStatus').trigger('disconnected')
      console.log "Disconnected to StatusChannel"
    received: (data) ->
      $('#serverStatus').trigger(data["status"])
