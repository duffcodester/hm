class AssignedChallengesController < ApplicationController
  def new
    @challenges = current_user.challenges + Challenge.where("public = ?", true).where("parent_id != ?", current_user.id)
    @children = current_user.children
    @assigned_challenge = AssignedChallenge.new
  end

  def your
    @your_assigned_challenges = current_user.assigned_challenges
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
      if @assigned_challenge.accepted
        flash.now[:success] = "Challenge Accepted"
        render 'show'
      elsif @assigned_challenge.rejected
        flash.now[:success] = "Challenge Rejected"
        render 'show'
      elsif @assigned_challenge.completed
        flash.now[:success] = "Challenge Completed"
        render 'show'
      elsif @assigned_challenge.validated
        flash.now[:success] = "Challenge Validated"
        #@assigned_challenge.child.points += @assigned_challenge.points
        #@assigned_challenge.child.save!
        @assigned_challenge.child.update_attribute(:points, @assigned_challenge.child.points + @assigned_challenge.points)
        render 'show'
      end          
    else
      flash.now[:error] = "Error accepting challenge"
      render 'show'
    end
  end

  #Unassigns a challenge to a child
  def destroy
    AssignedChallenge.find(params[:id]).destroy
    flash[:success] = "Challenge unassigned"
    redirect_to assigned_challenges
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
