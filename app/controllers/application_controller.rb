class ApplicationController < ActionController::API
  def jwt_init
    @@jwt_extended = JwtExtended.new
    @@jwt_extended.config(ENV['SECRET_KEY_BASE'], 15.minutes, 2.weeks)
  end

  def jwt_required
    begin
      token = request.authorization
    rescue NoMethodError
      return render status: 401
    end

    payload = @@jwt_extended.get_jwt_payload(token)

    return render status: 401 unless payload
    return render status: payload['err'] if payload['err']
    return render status: 403 unless payload['type'] == 'access_token'
  end

  def refresh_token_required
    begin
      token = request.authorization
    rescue NoMethodError
      return render status: 401
    end

    payload = @@jwt_extended.get_jwt_payload(token)

    return render status: 401 unless payload
    return render status: payload['err'] if payload['err']
    return render status: 403 unless payload['type'] == 'refresh_token'
  end

  def create_auth_code
    auth_code = ''
    array = ('a'..'z').to_a + (0..9).to_a
    6.times do
      auth_code += array[rand(35)].to_s
    end
    auth_code
  end
end
