class RewardsController < ApplicationController
  def community_pool
    @rewards = Reward.search(params[:search])
  end

  def your
    @your_rewards = current_user.rewards
  end
end