class CommentsController < ApplicationController
  before_action :jwt_init
  before_action :jwt_required

  def create
    return render status: 400 if params[:tweetId].nil? || params[:comment].nil?

    payload = @@jwt_extended.get_jwt_payload(request.authorization)

    begin
      Comment.create!(user_id: payload['user_id'],
                      tweet_id: params[:tweetId],
                      comment: params[:comment])
    rescue ActiveRecord::RecordInvalid
      return render status: 404
    end
    render status: 201
  end

  def destroy

  end

  def show

  end
end
