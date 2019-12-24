class AuthsController < ApplicationController
  before_action :jwt_init
  before_action :refresh_token_required, only: :update

  def create
    user = User.find_by_email(params[:email])
    return render status: 401 unless user

    if user.authenticate(params[:password])
      render json: { access_token: @@jwt_extended.create_access_token(user_id: user.id),
                     refresh_token: @@jwt_extended.create_refresh_token(user_id: user.id),
                     user_id: user.id },
             status: 200
    else
      render status: 401
    end
  end

  def update
    payload = @@jwt_extended.get_jwt_payload(request.authorization)
    render json: { access_token: @@jwt_extended.create_access_token(payload) },
           status: 200
  end
end
