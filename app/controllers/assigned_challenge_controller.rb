class AssignedChallengeController < ApplicationController
  #Assigns a challenge to a child
  def create
    @assigned_challenge = current_user.assigned_challenges.build(params[:assigned_challenge])
    if @assigned_challenge.save
      flash[:sucess] = "You have successfully assigned challenge!"
      redirect_to @assigned_challenge
    else
      render 'new'
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
