class RoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from "room_#{params[:room_id]}_channel"
    logger.add_tags "ActionCable_#{params[:room_id]}"
  end

  def unsubscribed
    # any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    current_user.messages.create! content: data["message"],
                                  user_id: data["user_id"],
                                  room_id: data["room_id"]
  end
  
end
