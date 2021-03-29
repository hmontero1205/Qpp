# All routes except :index and :show require authentication beforehand
# See routes.rb for details

class OfficeHoursController < ApplicationController

  def index

    @ohs = OfficeHour.with_search(params[:search], params[:asc])

    @tclass = ''
    @rdclass = ''
    @fugclass = ''

    if params[:asc].to_s == :host.to_s
      @tclass = 'hilite bg-warning'
    elsif params[:asc].to_s == :class_name.to_s
      @rdclass = 'hilite bg-warning'
    elsif params[:asc].to_s == :time.to_s
      @fugclass = 'hilite bg-warning'
    end
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @oh = OfficeHour.find(id) # look up movie by unique ID

    #if Time.now() < @oh.time or Time.now() > @oh.time + 60*60
    if !@oh.active
      flash.now[:notice] = "This OH is not currently active"
    end

    @queue_entries = @oh.queue_entries.order(start_time: :asc)
  end

  def destroy
    @oh = OfficeHour.find(params[:id])
    # TODO(etm): It seems like we can abstract this pattern into a function, but when I tried
    #   I couldn't use redirect_to
    if @oh.user != current_user
      flash[:notice] = "You cannot delete this OH since you did not create it."
      redirect_to office_hours_path
      return
    end
    
    @oh.destroy
    flash[:notice] = "#{@oh.host}'s #{@oh.class_name} OH was successfully deleted."
    redirect_to office_hours_path
  end

  def create
    @oh = current_user.office_hours.create(office_hour_params)
    if @oh.invalid?
      flash[:notice] = @oh.errors.full_messages.join('. ')
      render :new
      return
    end

    flash[:notice] = "#{@oh.host}'s #{@oh.class_name} OH was successfully created."
    redirect_to office_hours_path
  end

  def edit
    @oh = OfficeHour.find(params[:id])
    if @oh.user != current_user
      flash[:notice] = "You cannot edit this OH since you did not create it."
      redirect_to office_hours_path
    end
  end

  def update
    @oh = OfficeHour.find(params[:id])
    if @oh.user != current_user
      flash[:notice] = "You cannot edit this OH since you did not create it."
      redirect_to office_hours_path
      return
    end

    @oh.update(office_hour_params)
    flash[:notice] = "#{@oh.host}'s OH was successfully updated."
    redirect_to office_hour_path(@oh)
  end

  def new
    # Empty object so the template renders properly
    @oh = OfficeHour.new
  end

  def activate
    @oh = OfficeHour.find(params[:id])
    @oh.active = true
    @oh.save

    respond_to do |format|
      format.js {render inline: "App.oh.speak(\"refresh\", {});" }
    end
  end

  def deactivate
    @oh = OfficeHour.find(params[:id])
    @queue_entries = @oh.queue_entries.order(start_time: :asc)
    for quentry in @queue_entries
      quentry.destroy
      Chat.where(queue_entry_id: quentry.id).destroy_all
    end
    @oh.active = false
    @oh.save

    respond_to do |format|
      format.js {render inline: "App.oh.speak(\"refresh\", {});" }
    end
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def office_hour_params
    params.require(:office_hour).permit(:host, :class_name, :time, :zoom_info, :email, :active)
  end
end
