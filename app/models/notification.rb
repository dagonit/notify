class Notification < ApplicationRecord

  def deactivate
    update(active: false)
  end

end
