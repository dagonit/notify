class NotificationsController < ApplicationController

  def index
    notifications = Notification.where(user_id: params[:user_id])
    render json: notifications, status: 200
  end

  def create
    notification = Notification.create(accetable_params!)

    render json: { errors: notification.errors}, status: 422 and return unless notification.valid?
    render json: notification
  end

private
  def accetable_params!
    params.permit(:description, :user_id)
  end
end
