class TalkChannel < ApplicationCable::Channel
  def subscribed
    stream_from "talk:#{params[:type]}"
  end

  def options
    options = JSON.parse(Redis.current.get("say_service:options"))
    ActionCable.server.broadcast("talk:options", options)
  end

  def receive data
    Redis.current.lpush "say_commands", data.to_json
  end

end
