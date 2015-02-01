class SharingsController < ApiController
  before_action :set_sharing, only: [:show, :destroy, :parent, :children]
  
  def index
    @sharings = current_user.sharings
    render json: @sharings
  end

  def show
    render json: @sharing
  end

  def create
    @sharing = Sharing.new(sharing_params)
    if @sharing.save
      render json: @sharing, status: :created, location: @sharing
    else
      render json: @sharing.errors.full_messages, status: :unprocesable_entity
    end
  end

  def destroy
    @sharing.destroy
    head :no_content
  end

  def shared
    @sharings = current_user.shared_files
    render json: @sharings
  end

  private

  def set_sharing
    @directory = Sharing.find_by_id(params[:id])
    unless @sharing || @sharing.try(:user) == current_user || @sharing.try(:file_entity).try(:user) == current_user
      render json: 'Sharing with such id does not exist, or is not yours', status: :bad_request
    end
  end

  def sharing
    params.require(:sharing).permit(:file_entity_id, :user_id)
  end
end