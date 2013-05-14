class ResourcesController < ApplicationController
  def new
    @resource = resource_type.new
    @categories = Category.all if resource_type == Challenge
  end

  def index
    @resources = Resource.where(type: params[:type])
  end

  def community_pool
    @community_pool = Resource.search(params[:search])
  end

  def show
    @resource = Resource.where("type = ?", params[:type]).find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @resource }
    end
  end

  def your
    @your_resources = current_user.resources
  end

  def create
    # different methods to do this right now
    # 1) add has_many: resources to parents and do this:
    #@resource = current_user.resources.build(params[:resource])
    # 2) make parent_id accessible
    #@resource = resource_type.new(params[:resource])
    @resource = resource_type.new(params[params[:type].downcase.to_sym])
    @resource.parent_id = current_user.id 
    # 3) no change elsewhere
    #if params[:type] == "Challenge"
    #  @resource = current_user.challenges.build(params[:resource])
    #elsif params[:type] == "Reward"
    #  ...
    #end

    respond_to do |format|
      format.html do
        if @resource.save
          flash[:success] = "You successfully created a #{params[:type].downcase}!"
          redirect_to parent_dash_path
        else
          render 'new'
        end
      end

      format.json do
        if @resource.save
          render json: @resource
        else
          render json: {error: "problem saving resource in create method resource controller"}
        end
      end
    end
  end

  private
    def resource_type
      params[:type].constantize
    end
end