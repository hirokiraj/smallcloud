class QuotaController < ApiController
  def quota
    render json: "Your files take #{current_user.quota} out of #{Rails.application.secrets.max_quota} availible for you", status: :ok
  end
end