class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @events = Event.order(:start_date)
  end

  def show
    @user = current_user
    @event = Event.find(params[:id])
    @location = @event.location
    @artists = @event.artists
  end

  def new
    @event = Event.new
    @artists = Artist.all
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
      if params[:artist_id].present?
        EventArtist.create(event: @event, artist: Artist.find(params[:artist_id]))
      elsif params[:artist_name].present?
        artist = Artist.find_or_create_by(name: params[:artist_name])
        EventArtist.create(event: @event, artist: artist)
      end
      redirect_to @event
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
    @artists = Artist.all
  end

  def update
    @event = Event.find(params[:id])
    if params[:event][:location_id].present?
      @event.location = Location.find(params[:event][:location_id])
    elsif params[:event][:location_name].present?
      @event.location = Location.find_or_create_by(name: params[:event][:location_name])
    end
    if @event.update(event_params)
      if params[:artist_id].present?
        EventArtist.find_or_create_by(event: @event, artist: Artist.find(params[:artist_id]))
      elsif params[:artist_name].present?
        artist = Artist.find_or_create_by(name: params[:artist_name])
        EventArtist.find_or_create_by(event: @event, artist: artist)
      end
      redirect_to @event
    else
      render :edit
    end
  end


  private

  def event_params
    params.require(:event).permit(:name, :start_date, :location_id, :description, :location_name)
  end
end
