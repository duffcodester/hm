class ChallengesController < ApplicationController
  def new
    @challenge = Challenge.new
  end

  def index
    @challenge = Challenge.all
  end

  def community_pool
    @community_pool = Challenge.where("public = ?", true)
  end

  def show
    @challenge = Challenge.find(params[:id])
  end

  def your
    @your_challenges = current_user.challenges
  end

  def create
    @challenge = current_user.challenges.build(params[:challenge])
    if @challenge.save
      flash[:success] = "You successfully created a challenge!"
      redirect_to @challenge
    else
      render 'new'
    end
  end
end
