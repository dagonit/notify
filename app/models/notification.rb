class Notification < ApplicationRecord

  def deactivate
    update(active: false)
    { message: 'notification deleted' }
  end

end
