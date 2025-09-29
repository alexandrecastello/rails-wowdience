class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = current_user.reviews.includes(:event).order(created_at: :desc)
  end

  def show
  end

  def new
    redirect_to new_review_step1_path
  end

  def step1
    @events = Event.all.order(:name)
    @event = Event.new
  end

  def step2
    if params[:event_id].present?
      @event = Event.find(params[:event_id])
    elsif params[:event].present?
      @event = Event.new(event_params)
      @event.event_type = EventType.find_by(name: "Concert") || EventType.first

      # Handle location
      if params[:event][:location_id].present?
        @event.location = Location.find(params[:event][:location_id])
      elsif params[:event][:location_name].present?
        @event.location = Location.find_or_create_by(name: params[:event][:location_name])
      end

      if @event.save
        @event = Event.last
      else
        redirect_to new_review_step1_path, alert: 'Houve um erro ao criar o evento.'
        return
      end
    else
      redirect_to new_review_step1_path, alert: 'Por favor, selecione ou crie um evento.'
      return
    end

    @review = Review.new
  end

  def create_step2
    # Debug: log the parameters
    Rails.logger.debug "Params: #{params.inspect}"

    event_id = params[:review][:event_id] || params[:event_id]

    unless event_id.present?
      redirect_to new_review_step1_path, alert: 'Evento não encontrado. Tente novamente.'
      return
    end

    @event = Event.find(event_id)
    @review = Review.new(review_params)
    @review.user = current_user
    @review.event = @event

    if @review.save
      redirect_to @review, notice: 'Sua avaliação foi criada com sucesso!'
    else
      render :step2, alert: 'Houve um erro ao criar a avaliação.'
    end
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.event_id = params[:event_id]
    if @review.save
      redirect_to event_path(@review.event), notice: 'Avaliação criada com sucesso.'
    else
      redirect_to event_path(@review.event), alert: 'Houve um erro ao criar a avaliação.'
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @review, notice: 'Avaliação atualizada com sucesso.'
    else
      render :edit, alert: 'Houve um erro ao atualizar a avaliação.'
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path, notice: 'Avaliação excluída com sucesso.'
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :event_id)
  end

  def event_params
    params.require(:event).permit(:name, :start_date, :description, :location_id, :location_name)
  end
end
