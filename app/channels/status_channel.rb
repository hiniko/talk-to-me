class StatusChannel < ActionCable::Channel::Base
  def subscribed
    stream_from "status"    
  end  

  def receive data
    Redis.current.lpush "say_commands", data.to_json
  end
end
