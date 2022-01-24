class Task < ApplicationRecord
  validates_presence_of :name

  def complete!
    update_attribute(:done, true)
  end
end
