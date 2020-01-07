class FollowsController < ApplicationController
  before_action :jwt_init
  before_action :jwt_required

  def follower_get
    payload = @@jwt_extended.get_jwt_payload(request.authorization)
    follower_users = []

    follower_users_hash = Follow.where(follower_id: payload['user_id'],
                                       accepted: true)
    follower_users_hash.each do |follower_user|
      follower_users.append(follower_user.following_id)
    end

    follower_users.delete(payload['user_id'])

    render json: { follower_users: follower_users },
           status: 200
  end

  def following_get
    payload = @@jwt_extended.get_jwt_payload(request.authorization)
    following_users = []

    following_users_hash = Follow.where(following_id: payload['user_id'],
                                        accepted: true)
    following_users_hash.each do |following_user|
      following_users.append(following_user.follower_id)
    end

    following_users.delete(payload['user_id'])

    render json: { following_users: following_users },
           status: 200
  end

  def follow_status_get
    payload = @@jwt_extended.get_jwt_payload(request.authorization)

    following_user = []
    follower_user = []

    begin
      following_list = Follow.where(following_id: payload['user_id'], accepted: false)

      following_list.each do |following|
        following_user.append(following.follower_id)
      end

    rescue NoMethodError
      following_user = nil
    end

    begin
    follower_list = Follow.where(follower_id: payload['user_id'], accepted: false)

    follower_list.each do |follower|
      follower_user.append(follower.following_id)
    end

    rescue NoMethodError
      follower_user = nil
    end

    render json: { following: following_user,
                   follower: follower_user },
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

  def update
    payload = @@jwt_extended.get_jwt_payload(request.authorization)

    follow = Follow.find_by_following_id_and_follower_id(params[:userId],
                                                         payload['user_id'])
    return render status: 404 unless follow

    if params[:accepted]
      follow.accepted = params[:accepted]
      follow.save
    else
      follow.destroy!
    end

    render status: 204
  end

  def destroy_following
    payload = @@jwt_extended.get_jwt_payload(request.authorization)

    follow = Follow.find_by_following_id_and_follower_id(params[:userId],
                                                         payload['user_id'])

    if follow
      follow.destroy!
    else
      render status: 404
    end
  end

  def destroy_follower
    payload = @@jwt_extended.get_jwt_payload(request.authorization)

    follow = Follow.find_by_follower_id_and_following_id(params[:userId],
                                                         payload['user_id'])

    if follow
      follow.destroy!
    else
      render status: 404
    end
  end
end
