class TweetsController < ApplicationController
  before_action :jwt_init
  before_action :jwt_required, only: %i[show show_many create like_post timeline_get]

  def show
    return render status: 400 unless params[:tweetId]

    payload = @@jwt_extended.get_jwt_payload(request.authorization)

    tweet = Tweet.find_by_id(params[:tweetId])
    return render status: 404 unless tweet

    comments = tweet.comments.ids
    imgs = tweet.tweet_imgs.ids


    render json: { content: tweet.content,
                   user_name: tweet.user.name,
                   user_profile: tweet.user.user_imgs.last.source,
                   writed_at: tweet.created_at,
                   images: imgs,
                   like: tweet.likes.count,
                   liked?: !tweet.likes.find_by_user_id(payload['user_id']).nil?,
                   comments: comments },
           status: 200
  end

  def show_many
    return render status: 400 unless params[:page]

    user = User.find_by_id(params[:userId])
    tweets = user.tweets.order(created_at: :desc).limit(10).offset(10 * params[:page].to_i).ids

    render json: { tweets: tweets },
           status: 200
  end

  def timeline_get
    return render status: 400 unless params[:page]

    payload = @@jwt_extended.get_jwt_payload(request.authorization)

    related_user_ids = []
    Follow.where(following_id: payload['user_id'], accepted: true).each do |follow|
      related_user_ids.append(follow.follower_id)
    end

    Follow.where(follower_id: payload['user_id'], accepted: true).each do |follow|
      related_user_ids.append(follow.following_id)
    end

    tweets = Tweet.where(user_id: related_user_ids).order(created_at: :desc).limit(10)
                  .offset(10 * params[:page].to_i).ids

    render json: { tweets: tweets },
           status: 200
  end

  def create
    return render status: 400 unless params[:content]

    payload = @@jwt_extended.get_jwt_payload(request.authorization)
    user = User.find_by_id(payload['user_id'])
    tweet = user.tweets.create!(content: params[:content])

    5.times do |i|
      tweet.tweet_imgs.create!(source: params[i.to_s]) if params[i.to_s]
    end

    render status: 201
  end

  def destroy
    payload = @@jwt_extended.get_jwt_payload(request.authorization)
    user = User.find_by_id(payload['user_id'])
    tweet = user.tweets.find_by_id(params[:tweetId])

    return render status: 404 unless tweet

    tweet.tweet_imgs.each do |tweet_img|
      FileUtils.rm_rf(ENV['ROOT_PATH'] + tweet_img.id.to_s)
    end

    begin
      tweet.destroy!
    rescue NoMethodError
      render status: 404
    end

    render status: 200
  end

  def like_post
    payload = @@jwt_extended.get_jwt_payload(request.authorization)
    user = User.find_by_id(payload['user_id'])
    tweet = Tweet.find_by_id(params[:tweetId])

    return render status: 404 unless tweet

    begin
      tweet.likes.create!(user_id: user.id)
    rescue ActiveRecordError::RecordNotUnique
      tweet.likes.find_by_user_id(user.id).destroy!
    end
  end
end
