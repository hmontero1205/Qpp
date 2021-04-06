class OfficeHourRecurrence < ApplicationRecord
  INT_DAY = { sunday: 7, monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6 }
  DAY_INT = { 7 => :sunday, 1 => :monday, 2 => :tuesday, 3 => :wednesday, 4 => :thursday, 5 => :friday, 6 => :saturday }
  belongs_to :office_hour
  # validates :day_of_week, inclusion: { in: %w(sunday monday tuesday wednesday thursday friday saturday),
  #                                      message: "%{value} is not a valid day of the week" }

  def self.normalize(form_data)
    # Normalizes the form data {'monday' => '1', 'tuesday' => '2'}
    r = []
    form_data.each do |day, active|
      if active == "1"
        r.append INT_DAY[day.to_sym]
      end
    end
    r
  end

  def self.de_normalize(int_array)
    r = {}
    int_array.each do |day_int|
      # The format the form erb uses
      r[DAY_INT[day_int].to_s] = '1'
    end
    r
  end
end
