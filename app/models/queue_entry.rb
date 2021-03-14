class QueueEntry < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :office_hour, optional: false
end
