class ChallengesController < ApplicationController
  def new
    @challenge = Challenge.new
  end

  def index
    @challenge = Challenge.all
  end

  def show
    @challenge = Challenge.find(params[:id])
  end

  def create
    @challenge = Challenge.new(params[:challenge])
    if @challenge.save
      flash[:success] = "You successfully created a challenge!"
      redirect_to @challenge
    else
      render 'new'
    end
  end
end
