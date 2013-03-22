class ChallengesController < ApplicationController
  def new
    @categories = Category.all
  end

  def community_pool
    @community_pool = Challenge.search(params[:search])
  end

  def your
    @your_challenges = current_user.challenges
  end
end