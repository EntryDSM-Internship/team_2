class FollowsController < ApplicationController
  before_action :jwt_init
  before_action :jwt_required

  def follower_get
    payload = @@jwt_extended.get_jwt_payload(request.authorization)
    follower_users = {}
    cnt = 1

    follower_users_hash = Follow.where(following_id: payload['user_id'])
    follower_users_hash.each do |follower_user|
      follower_users[cnt] = follower_user.follower_id
      cnt += 1
    end

    render json: follower_users,
           status: 200
  end

  def following_get
    payload = @@jwt_extended.get_jwt_payload(request.authorization)
    following_users = {}
    cnt = 1

    following_users_hash = Follow.where(following_id: payload['user_id'])
    following_users_hash.each do |following_user|
      following_users[cnt] = following_user.follower_id
      cnt += 1
    end

    render json: following_users,
           status: 200
  end

  def following_post
    payload = @@jwt_extended.get_jwt_payload(request.authorization)

    begin
      Follow.create!(following_id: payload['user_id'],
                     follower_id: params[:userId])
    rescue ActiveRecord::RecordInvalid
      return render status: 404
    rescue ActiveRecord::RecordNotUnique
      return render status: 409
    end
    render status: 201
  end
end
