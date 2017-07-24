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
    while true 
      # Wait for a command to be published
      command = Redis.current.blpop "say_commands"
      puts command.inspect
    end
  end
end
