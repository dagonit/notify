class ActivityChannel < ApplicationCable::Channel
  def subscribed
    stream_from "activity_channel"
  end
end
