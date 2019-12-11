class ImagesController < ApplicationController
  def show
    img = TweetImg.find_by_id(params[:imageId])
    return render status: 404 unless img

    render json: { img: img.source },
           status: 200
  end

  def show_many
    tweet = Tweet.find_by_id(params[:tweetId])
    render status: 404 unless tweet

    imgs = []
    tweet.tweet_imgs.each do |tweet_img|
      imgs.append(tweet_img.id)
    end

    render json: { imgs: imgs },
           status: 200
  end
end
