class FileEntitiesController < ApiController
  def index
    @file_entities = current_user.file_entities
    render json: @file_entities
  end

  def show
    render josn: @file_entity
  end

  def create
    @file_entity = FileEntity.new(file_entity_params)
    if @file_entity.save
      render json: @file_entity, status: :created, location: @file_entity
    else
      render json: @file_entity.errors.full_messages, status: :unprocesable_entity
    end
  end

  def destroy
    @directory.destroy
    head :no_content
  end

  def parent
    @parent = @file_entity.directory
    render json: @parent, location: @parent
  end

  private

  def set_file_entity
    @file_entity = FileEntity.find_by_id(params[:id])
    unless @directory || @directory.try(:user) == current_user
      render json: 'File entity with such id does not exist, or is not yours', status: :bad_request
    end
  end

  def file_entity_params
    params.require(:file_entity).permit(:directory_id, :attachment)
  end
end