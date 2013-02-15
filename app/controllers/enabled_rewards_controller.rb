class EnabledRewardsController < ApplicationController
  def new
    @rewards = current_user.rewards + Reward.where("public = ?", true).where("parent_id != ?", current_user.id)
    @children = current_user.children
    @enabled_reward = EnabledReward.new
  end

  def create
    @rewards = current_user.rewards + Reward.where("public = ?", true).where("parent_id != ?", current_user.id)
    @children = current_user.children
    @enabled_reward = current_user.enabled_rewards.build(params[:enabled_reward])
    if @enabled_reward.save
      flash[:success] = "You have successfully enabled reward!"
      redirect_to @enabled_reward
    else
      render 'new'
    end
  end

  def show
    @enabled_reward = EnabledReward.find(params[:id])
  end
end
