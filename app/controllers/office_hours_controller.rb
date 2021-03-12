class OfficeHoursController < ApplicationController

  def index
    @ohs = OfficeHour.all
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @oh = OfficeHour.find(id) # look up movie by unique ID

    # curr time between oh time and an hour after
    # more flexible for repeated meetings?
    # should probs get length from user? must discuss
    if Time.now() < @oh.time or Time.now() > @oh.time + 60*60
      flash.now[:notice] = "This OH is not currently active"
    end
    @queue_entries = QueueEntry.all
  end

  def destroy
    @oh = OfficeHour.find(params[:id])
    @oh.destroy
    flash[:notice] = "#{@oh.host}'s #{@oh.class_name} OH was successfully deleted."
    redirect_to office_hours_path
  end

  def create
    @oh = OfficeHour.create!(office_hour_params)
    flash[:notice] = "#{@oh.host}'s #{@oh.class_name} OH was successfully created."
    redirect_to office_hours_path
  end

  def edit
    @oh = OfficeHour.find(params[:id])
  end

  def update
    @oh = OfficeHour.find(params[:id])
    @oh.update_attributes!(office_hour_params)
    flash[:notice] = "#{@oh.host}'s OH was successfully updated."
    redirect_to office_hour_path(@oh)
  end

  def new
    if !user_signed_in?
      flash[:notice] = "You need to be signed in to do this!"
      redirect_to new_user_session_path
    end

  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def office_hour_params
    params.require(:office_hour).permit(:host, :class_name, :time, :zoom_info, :email)
  end
end
