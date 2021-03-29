class OfficeHour < ActiveRecord::Base
  validates :host, presence: true, allow_blank: false
  validates :class_name, presence: true, allow_blank: false
  # We don't actually need to ensure it's a valid date since the form
  # date picker only submits valid dates.
	validates :starts_on, presence: true, allow_blank: false
	validates :ends_on, presence: true, allow_blank: false
  validates :zoom_info, presence: true, allow_blank: false

  belongs_to :user
  has_many :queue_entries, -> {order("start_time asc")}
	has_many :office_hour_recurrence, dependent: :destroy

  def self.with_search(search, order)
  	if order.nil?
  	 oh = OfficeHour.all
  	else
  	 oh = OfficeHour.order(order)
  	end

  	if search.nil?
  		return oh
  	end
  	
  	return oh.where('host LIKE :search OR class_name LIKE :search', search: "%#{search[:search]}%")
  end
end
