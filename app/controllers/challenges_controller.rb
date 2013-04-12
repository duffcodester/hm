class ChallengesController < ApplicationController
  def new
    @categories = Category.all
  end

  def community_pool
    @community_pool = Challenge.search(params[:search])

    respond_to do |format|
      format.html
      format.json { render json: @community_pool }
    end
  end

  def your
    @your_challenges = current_user.challenges
  end
end