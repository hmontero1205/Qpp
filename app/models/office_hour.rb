class OfficeHour < ActiveRecord::Base
  validates :host, presence: true, allow_blank: false
  validates :class_name, presence: true, allow_blank: false
  # We don't actually need to ensure it's a valid date since the form
  # date picker only submits valid dates.
  validates :time, presence: true, allow_blank: false
  validates :zoom_info, presence: true, allow_blank: false

  belongs_to :user
  has_many :queue_entries, -> {order("start_time asc")}
end
