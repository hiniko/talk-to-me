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
    loop do 
      #Wait for a command to be published
      voice, message = JSON.parse((Redis.current.blpop "say_commands")[1]).values
      @service.say voice, message
    end
  end
end
