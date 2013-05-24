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
    @assigned_challenge = current_user.assigned_challenges.build(params[:assigned_challenge])
    if params[:assigned_challenge][:challenge_id]
      challenge = Challenge.find(params[:assigned_challenge][:challenge_id]) 
      @assigned_challenge.category_id = challenge.category_id
    end

    respond_to do |format|
      format.html do
        if @assigned_challenge.save
          flash[:success] = "You have successfully assigned challenge!"
          redirect_to challenges_community_pool
        else
          render 'new'
        end
      end

      format.json do
        if @assigned_challenge.save
          render json: @assigned_challenge
        else
          render json: error_info(@assigned_challenge, params)
        end
      end
    end
  end

  def update
    @assigned_challenge = AssignedChallenge.find(params[:id])

    respond_to do |format|
      format.html do
        if @assigned_challenge.update_attributes(params[:assigned_challenge])
          if @assigned_challenge.accepted
            if signed_in_as_child?
              flash[:success] = "Challenge Accepted"
              redirect_to @assigned_challenge.child
            elsif signed_in_as_parent?
              flash[:success] = "Challenge returned to child"
              redirect_to parent_dash_path
            end
              
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

      format.json do
        if @assigned_challenge.update_attributes(params[:assigned_challenge])
          if @assigned_challenge.accepted
            if signed_in_as_child?
              #flash[:success] = "Challenge Accepted"

            elsif signed_in_as_parent?
              #flash[:success] = "Challenge returned to child"
            end
          elsif @assigned_challenge.rejected
            #flash[:success] = "Challenge Rejected"
            @assigned_challenge.destroy
          elsif @assigned_challenge.completed
            #flash[:success] = "Challenge Completed"
          elsif @assigned_challenge.validated
            #flash[:success] = "Challenge Validated"
            @assigned_challenge.child.update_attribute(:points, 
              @assigned_challenge.child.points + @assigned_challenge.points)
            @assigned_challenge.destroy
          end          

          render json: @assigned_challenge
        else
          #flash.now[:error] = "Error accepting challenge"
          render json: error_info(@assigned_challenge, params)
        end
      end
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

    respond_to do |format|
      format.html
      format.json { render json: @assigned_challenge }
    end
  end

  #Child rejects challenge
  def reject
    AssignedChallenge.find(params[:id]).destroy
    flash[:success] = "Challenge Rejected"
    redirect_to child
  end

  def completed
    @completed_challenges = current_user.assigned_challenges.where("parent_id =?", current_user.id).where("completed =?", true)

    respond_to do |format| 
      format.json { render json: @completed_challenges }
    end
  end

  private

    def error_info(assigned_challenge, params)
      {errors: assigned_challenge.errors.full_messages, 
        assigned_challenge: assigned_challenge,
        params: params}
    end
end
