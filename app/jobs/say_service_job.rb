class SayServiceJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @service = SayService.new
    @service.on_notify do |state, event|
      ActionCable.server.broadcast("status",
         status: state.to_s,
         event: event.to_s
      )  
    end 
    @service.run
  end
end
