class OfficeHour < ActiveRecord::Base
  validates :host, presence: true, allow_blank: false
  validates :class_name, presence: true, allow_blank: false
  # We don't actually need to ensure it's a valid date since the form
  # date picker only submits valid dates.
  validates :time, presence: true, allow_blank: false
  validates :zoom_info, presence: true, allow_blank: false

  belongs_to :user
  has_many :queue_entries, -> {order("start_time asc")}

  def self.with_search(search)
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies

  	# if order.nil?
  	oh = OfficeHour.all
  	# else
  	# 	moves = Movie.order(order)
  	# end

  	if search.nil?
  		return oh
  	end
  	
  	return oh.where('host LIKE :search OR class_name LIKE :search', search: "%#{search[:search]}%")
  end
end
