class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.event_id = params[:event_id]
    if @review.save
      redirect_to event_path(@review.event), notice: 'Review was successfully created.'
    else
      redirect_to event_path(@review.event), alert: 'There was an error creating the review.'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
