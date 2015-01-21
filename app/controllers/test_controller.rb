class TestController < ApiController
  def secured
    render json: 'Secured site', status: 200
  end
end