class StatusChannel < ActionCable::Channel::Base
  def subscribed
    stream_from "status"    
  end  
end
