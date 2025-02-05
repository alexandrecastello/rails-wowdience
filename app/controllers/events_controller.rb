class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @user = current_user
    @event = Event.find(params[:id])
    @location = @event.location
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.event_type = EventType.find_by_name("Concert")
    if params[:event][:location_id].present?
      @event.location = Location.find(params[:event][:location_id])
    elsif params[:event][:location_name].present?
      @event.location = Location.find_or_create_by(name: params[:event][:location_name])
    end
    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if params[:event][:location_id].present?
      @event.location = Location.find(params[:event][:location_id])
    elsif params[:event][:location_name].present?
      @event.location = Location.find_or_create_by(name: params[:event][:location_name])
    end
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_date, :location_id, :description, :location_name)
  end
end
