class RootController < ApplicationController
  def root
    redirect_to 'https://app.swaggerhub.com/apis-docs/o_ozogie/MINITWEET/1.0.0'
  end
end
