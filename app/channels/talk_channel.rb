class TalkChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages"
    stream_from "talk:#{params[:type]}"
  end

  def options
    options = JSON.parse(Redis.current.get("say_service:options"))
    ActionCable.server.broadcast("talk:options", options)
  end

  def received(data)
    puts data.inspect
  end

end
