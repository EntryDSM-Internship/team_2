class TweetsController < ApplicationController
  before_action :jwt_init
  before_action :jwt_required

  def show
    tweet = Tweet.find_by_id(params[:tweetid])
    return render status: 404 unless tweet

    comments = []
    tweet.comments.each do |comment|
      comments.append(comment.id)
    end

    imgs = []
    tweet.tweet_imgs.each do |img|
      imgs.append(img.id)
    end

    render json: { user_profile_img: tweet.user.profile_img,
                   user_name: tweet.user.name,
                   writed_at: tweet.created_at,
                   images: imgs,
                   like: '',
                   comments: comments },
           status: 200
  end

  def show_many
    payload = @@jwt_extended.get_jwt_payload(request.authorization)
    user = User.find_by_id(payload['user_id'])

    tweets = []
    user.tweets.order(created_at: :desc).limit(10).each do |tweet|
      tweets.append(tweet.id)
    end

    render json: { tweets: tweets }
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

    begin
      tweet.likes.create!(user_id: user.id)
    rescue ActiveRecordError::RecordNotUnique
      tweet.likes.find_by_user_id(user.id).destroy!
    end
  end
end
