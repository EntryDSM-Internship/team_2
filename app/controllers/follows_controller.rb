class FollowsController < ApplicationController
  before_action :jwt_init
  before_action :jwt_required

  def follower_get

  end

  def following_get

  end

  def following_post
    payload = @@jwt_extended.get_jwt_payload(request.authorization)
    user = User.find_by_id(payload['user_id'])

  end
end
