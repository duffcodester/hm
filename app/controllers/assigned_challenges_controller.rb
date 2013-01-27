class AssignedChallengesController < ApplicationController
  def new
    @challenges = current_user.challenges + Challenge.where("public = ?", true).where("parent_id != ?", current_user.id)
    @children = current_user.children
    @assigned_challenge = AssignedChallenge.new
  end

  def your
    @your_assigned_challenges = current_user.challenges
  end

  #Assigns a challenge to a child
  def create
    @challenges = current_user.challenges + Challenge.where("public = ?", true).where("parent_id != ?", current_user.id)
    @children = current_user.children
    @assigned_challenge = current_user.assigned_challenges.build(params[:assigned_challenge])
    if @assigned_challenge.save
      flash[:success] = "You have successfully assigned challenge!"
      redirect_to @assigned_challenge
    else
      render 'new'
    end
  end

  def update
    @assigned_challenge = AssignedChallenge.find(params[:id])
    if @assigned_challenge.update_attributes(params[:assigned_challenge])
      flash[:sucess] = "Challenge Accepted"
      render 'show'
    else
      flash[:error] = "Error accepting challenge"
      render 'show'
    end
  end

  #Unassigns a challenge to a child
  def destroy
    AssignedChallenge.find(params[:id]).destroy
    flash[:success] = "Challenge unassigned"
    redirect_to 'new'
  end

  def show
    @assigned_challenge = AssignedChallenge.find(params[:id])
  end

  #Child rejects challenge
  def reject
    AssignedChallenge.find(params[:id]).destroy
    flash[:success] = "Challenge Rejected"
    redirect_to child
  end
end
