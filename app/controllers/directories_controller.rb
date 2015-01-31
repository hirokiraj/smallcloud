class DirectoriesController < ApiController
  before_action :set_directory, only: [:show, :destroy, :parent, :children]
  
  def index
    @directories = current_user.directories.top_level
    render json: @directories
  end

  def show
    render json: @directory
  end

  def create
    @directory = Directory.new(directory_params.merge({user_id: current_user.id}))
    if @directory.save
      render json: @directory, status: :created, location: @directory
    else
      render json: @directory.errors.full_messages, status: :unprocesable_entity
    end
  end

  def destroy
    @directory.destroy
    head :no_content
  end

  def parent
    @parent = @directory.parent
    render json: @parent, location: @parent
  end

  def children
    @children = @directory.children
    render json: @children
  end

  private

  def set_directory
    @directory = Directory.find_by_id(params[:id])
    unless @directory || @directory.try(:user) == current_user
      render json: 'Directory with such id does not exist, or is not yours', status: :bad_request
    end
  end

  def directory_params
    params.require(:directory).permit(:name, :parent_id)
  end
end