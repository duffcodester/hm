class AssignedChallengesController < ApplicationController
  def new
    @challenges = current_user.challenges + Challenge.where("public = ?", true).where("parent_id != ?", current_user.id)
    @children = current_user.children
    @assigned_challenge = AssignedChallenge.new(params[:assigned_challenge])
  end

  def your
    @your_assigned_challenges = current_user.assigned_challenges
  end

  #Assigns a challenge to a child
  def create
    @challenges = current_user.challenges + Challenge.where("public = ?", true).where("parent_id != ?", current_user.id)
    @children = current_user.children
    @assigned_challenge = current_user.assigned_challenges.build(params[:assigned_challenge])

    challenge = Challenge.find(params[:assigned_challenge][:challenge_id])
    @assigned_challenge.category_id = challenge.category_id
    
    if @assigned_challenge.save
      flash[:success] = "You have successfully assigned challenge!"
      redirect_to parent_dash_path
    else
      render 'new'
    end
  end

  def update
    @assigned_challenge = AssignedChallenge.find(params[:id])
    if @assigned_challenge.update_attributes(params[:assigned_challenge])
      if @assigned_challenge.accepted
        flash[:success] = "Challenge Accepted"
        redirect_to @assigned_challenge.child
      elsif @assigned_challenge.rejected
        flash[:success] = "Challenge Rejected"
        redirect_to @assigned_challenge.child
        @assigned_challenge.destroy
      elsif @assigned_challenge.completed
        flash[:success] = "Challenge Completed"
        redirect_to @assigned_challenge.child
      elsif @assigned_challenge.validated
        flash[:success] = "Challenge Validated"
        @assigned_challenge.child.update_attribute(:points, 
          @assigned_challenge.child.points + @assigned_challenge.points)
        redirect_to parent_dash_path
        @assigned_challenge.destroy
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

  def completed_challenges 
    @completed_challenges = current_user.assigned_challenges.where("parent_id =?", @parent.id).where("completed =?", true)
    render json: @completed_challenges
  end
end
