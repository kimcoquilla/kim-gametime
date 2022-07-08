class ReviewsController < ApplicationController
  before_action :set_game, only: %i[new create]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.game = @game
    if @review.save
      redirect_to game_path(@game)
    else
      render :game
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to daycare_path(@review.game)
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def review_params
    params.require(:review).permit(:stars,
                                   :content,
                                   :user_id,
                                   :game_id)
  end
end
