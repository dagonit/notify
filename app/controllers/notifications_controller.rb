class NotificationsController < ApplicationController

  def create
    notification = Notification.new(accetable_params!)

    render json: { errors: notification.errors}, status: 422 and return unless notification.valid?

    render json: { notification: notification }, status: :created
  end

private
  def accetable_params!
    params.permit(:description, :user_id)
  end
end
