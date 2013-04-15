class RewardsController < ApplicationController
  def community_pool
    @community_pool = Reward.where(type: "Reward")

    respond_to do |format|
      format.html
      format.json { render json: @community_pool }
    end
  end

  def your
    @your_rewards = current_user.rewards
  end
end