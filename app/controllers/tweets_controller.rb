class TweetsController < ApplicationController
  before_action :jwt_init
  before_action :jwt_required

  def show

  end

  def show_many

  end

  def create
    return render json: 400 if params[:content]

    payload = @@jwt_extended.get_jwt_payload(request.authorization)
    user = User.find_by_id(payload['user_id'])
    user.tweets.create!(params[:content])
  end

  def destroy

  end
end
