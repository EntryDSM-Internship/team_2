class ApplicationController < ActionController::API
  def jwt_init
    @@jwt_extended = JwtExtended.new
    @@jwt_extended.config(ENV['SECRET_KEY_BASE'], 15.minutes, 2.weeks)
  end

  def jwt_required
    begin
      token = request.authorization[7..].to_s
    rescue NoMethodError
      render status: 401
    end

    payload = @@jwt_extended.get_jwt_payload(token)

    return render status: payload['err'] unless payload['err'].nil?
    return render status: 403 unless payload['type'] == 'access_token'
  end

  def refresh_token_required
    begin
      token = request.authorization[7..].to_s
    rescue NoMethodError
      return render status: 401
    end

    payload = @@jwt_extended.get_jwt_payload(token)

    return render status: 410 if payload['err'] == 410
    return render status: 403 unless payload['type'] == 'refresh_token'
  end
end
