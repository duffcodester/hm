class RewardsController < ApplicationController
  def new
    @reward = Reward.new
  end

  def index
    @reward = Reward.all
  end

  def community_pool
    @rewards = Reward.search(params[:search])
  end

  def show
    @reward = Reward.find(params[:id])
  end

  def your
    @your_rewards = current_user.rewards
  end

  def create
    @reward = current_user.rewards.build(params[:reward])
    if @reward.save
      flash[:success] = "You successfully created a reward!"
      redirect_to @reward
    else
      render 'new'
    end
  end
end
