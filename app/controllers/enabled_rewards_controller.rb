class EnabledRewardsController < ApplicationController
  def new
    @rewards = current_user.rewards + Reward.where("public = ?", true).where("parent_id != ?", current_user.id)
    @children = current_user.children
    @enabled_reward = EnabledReward.new(params[:enabled_reward])
  end

  def create
    @rewards = current_user.rewards + Reward.where("public = ?", true).where("parent_id != ?", current_user.id)
    @children = current_user.children
    @enabled_reward = current_user.enabled_rewards.build(params[:enabled_reward])
    if @enabled_reward.save
      flash[:success] = "You have successfully enabled reward!"
      redirect_to parent_dash_path
    else
      render 'new'
    end
  end

  def update
    @enabled_reward = EnabledReward.find(params[:id])
    child = @enabled_reward.child
    if @enabled_reward.points < @enabled_reward.child.points
      if @enabled_reward.update_attributes(params[:enabled_reward])
        if @enabled_reward.redeemed
        flash[:success] = "Reward Redeemed"
        child.update_attribute(:points,
          child.points - @enabled_reward.points)
        sign_in child
        redirect_to child
        @enabled_reward.destroy
        end
      else
        flash[:error] = "Error redeeming reward"
        redirect_to child
      end
    else
      flash[:error] = "Not enough points to redeem reward"
        redirect_to child
    end
  end

  def show
    @enabled_reward = EnabledReward.find(params[:id])
  end
end
