class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  # permit non-user to see the index and show
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @projects = policy_scope(Project)
    @projects = Project.all
  end

  def show
  end

  def edit
  end

  def update
    @project.update(project_params)
    redirect_to @project
  end

  def new
    # returns true if user is artist
    # current_user.artist
    @project = Project.new
    # authorize access to project/new page for all users
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    @project.artist = current_user
    authorize @project
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def destroy
    @project.destroy
    # should send artist to site for a new offer
    redirect_to new_project_path
  end

  private

  def set_project
    @project = Project.find(params[:id])
    authorize @project
  end

  def project_params
    params.require(:project).permit(:genre, :artistic_name, :description, :band_format, :photo, :video, :city)
  end
end
