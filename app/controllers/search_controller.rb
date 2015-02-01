class SearchController < ApiController
  def search
    if params[:search_term]
      @files = current_user.file_entities.where('attachment_file_name ilike ?', "#{params[search_term]}")
      render json: 'No files were found', status: :no_content if @files.empty?
      render json: @files
    else
      render json: 'You must provide a search term', status: :bad_request
    end
  end

  private
  def foo_params
    params.require(:search).permit(:search_term)
  end
end