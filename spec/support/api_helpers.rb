# helper that adds proper headers
def create_action_wrapper(body)
  post :create, body, { 'Accept' => 'application/json' , 'Content-Type' => 'application/json' }
  JSON.parse(response.body)
end

def get_action_wrapper(action_name, body)
  get action_name.to_sym, body, { 'Accept' => 'application/json' , 'Content-Type' => 'application/json' }
  JSON.parse(response.body)
end

def post_action_wrapper(action_name, body)
  post action_name.to_sym, body, { 'Accept' => 'application/json' , 'Content-Type' => 'application/json' }
  JSON.parse(response.body)
end

def logout_user(email, token)
  delete :destroy, {}, { 'Accept' => 'application/json' , 'Content-Type' => 'application/json'}
  JSON.parse(response.body)
end

def add_headers_to_request(email, authentication_token)
  request.headers["X-Doer-Email"] = email
  request.headers["X-Doer-Token"] = authentication_token
end

 def login_user
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user_with_directory)
    sign_in user
    @user = User.last
  end
end