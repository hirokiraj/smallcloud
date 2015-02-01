class SearchController < ApiController
  def search
    unless params[:search_term].blank?
      @files = current_user.file_entities.where('attachment_file_name ilike ?', "%#{params[:search_term]}%")
      if @files.empty?
        render json: 'No files were found', status: :no_content
      else
        render json: @files
      end
    else
      render json: 'You must provide a search term', status: :bad_request
    end
  end

  private
  def foo_params
    params.require(:search).permit(:search_term)
  end
end