class SayServiceJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Setup SayService
    @service = SayService.new

    @service.on_notify do |state, event|
      ActionCable.server.broadcast("status",
         status: state.to_s,
         event: event.to_s
      )  
    end 

    # Run service
    @service.run
    
    # Store options for clients to get if needed
    Redis.current.set("say_service:options", @service.voice_options.to_json)

    loop do 
      #Wait for a command to be published
      voice, message = JSON.parse((Redis.current.blpop "say_commands")[1]).values
      @service.say voice, message
    end
  end
end
