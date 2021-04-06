class OfficeHour < ActiveRecord::Base
  validates :host, presence: true, allow_blank: false
  validates :class_name, presence: true, allow_blank: false
  # We don't actually need to ensure it's a valid date since the form
  # date picker only submits valid dates.
  validates :starts_on, presence: true, allow_blank: false
  validates :ends_on, presence: true, allow_blank: false
  validates :zoom_info, presence: true, allow_blank: false
  validates :meeting_id, presence: true, allow_blank: false
  after_validation :strip_whitespace

  belongs_to :user
  has_many :queue_entries, -> { order("start_time asc") }
  has_many :office_hour_recurrence, dependent: :destroy

  def update_recurrences(active_days)
    transaction do
      office_hour_recurrence.destroy_all
      active_days.each do |day|
        office_hour_recurrence.create(day_of_week: day)
      end
    end
  end

  def recurrence_int_array
    r = []
    office_hour_recurrence.all.each do |rec|
      r.append(rec.day_of_week)
    end
    r
  end

  def self.with_search(search, order)
    if order.nil?
      oh = OfficeHour.all
    else
      oh = OfficeHour.order(order)
    end

    if search
      oh = oh.where('host LIKE :search OR class_name LIKE :search', search: "%#{search[:search]}%")
    end
    rehydrated = []
    oh.each do |event|
      if event.office_hour_recurrence.count > 0 and event.repeats_until
        # Maybe this can be simpler
        weekdays = event.office_hour_recurrence.select(:day_of_week)
        repeats_on = []
        weekdays.each do |wd|
          repeats_on.push wd.day_of_week
        end
        curr = event.starts_on.clone
        while curr < event.repeats_until + 1.day
          if repeats_on.include? curr.wday
            # Not sure if this is too hacky, but since we never save these to the database it should be fine
            o = OfficeHour.new id: event.id, starts_on: curr, host: event.host, class_name: event.class_name,
                               meeting_id: event.meeting_id, meeting_passcode: event.meeting_passcode
            rehydrated.push o
          end
          curr = curr + 1.day
        end
      else
        rehydrated.push(event)
      end
    end
    if order.eql? "starts_on" or order.nil?
      rehydrated = rehydrated.sort_by {|item| item.starts_on}
    end
    return rehydrated
  end

  private
  def strip_whitespace
    self.meeting_id = self.meeting_id.delete(' ') unless self.meeting_id.nil?
  end
end
