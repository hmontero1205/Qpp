class OfficeHourRecurrence < ApplicationRecord
  belongs_to :office_hour
  validates :day_of_week, inclusion: { in: %w(sunday monday tuesday wednesday thursday friday saturday),
                                       message: "%{value} is not a valid day of the week" }
end
