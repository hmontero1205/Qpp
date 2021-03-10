class OfficeHoursController < ApplicationController
  def index
    @ohs = OfficeHour.all
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @oh = OfficeHour.find(id) # look up movie by unique ID
    if Time.now() < @oh.time
      flash[:notice] = "This OH hasn't started yet"
    end
    @queue_entries = QueueEntry.all
  end

  def destroy
  end

  def create
    @oh = OfficeHour.create(office_hour_params)
    if @oh.invalid?
      flash[:notice] = @oh.errors.full_messages.join('. ')
      render :new
      return
    end
    flash[:notice] = "#{@oh.host}'s #{@oh.class_name} OH was successfully created."
    redirect_to office_hours_path
  end

  def update
  end

  def new
    @oh = OfficeHour.new()
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def office_hour_params
    params.require(:office_hour).permit(:host, :class_name, :time, :zoom_info)
  end
end
