class Notification < ApplicationRecord
  after_create_commit{ publish }

  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 200 }

  def deactivate
    update(active: false)
  end

  def publish
    ActionCable.server.broadcast('activity_channel', message: description)
  end
end
