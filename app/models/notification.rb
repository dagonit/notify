class Notification < ApplicationRecord
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 200 }

  def deactivate
    update(active: false)
    { message: 'notification deleted' }
  end

end
