class JwtExtended < ApplicationRecord
  def config(secret_key, access_exp, refresh_exp)
    @@secret_key = secret_key
    @@access_exp = access_exp
    @@refresh_exp = refresh_exp
    @@algorithm = 'HS256'

    raise Time::TypeError unless @@access_exp.class == ActiveSupport::Duration
    raise Time::TypeError unless @@refresh_exp.class == ActiveSupport::Duration
  end

  def create_access_token(payload)
    raise JWT::EncodeError unless payload[:exp].nil? || payload[:type].nil?

    payload[:exp] = (Time.now + @@access_exp).to_i
    payload[:type] = :access_token
    JWT.encode(payload, @@secret_key, @@algorithm)
  end

  def create_refresh_token(payload)
    raise JWT::EncodeError unless payload[:exp].nil? || payload[:type].nil?

    payload[:exp] = (Time.now + @@refresh_exp).to_i
    payload[:type] = :refresh_token
    JWT.encode(payload, @@secret_key, @@algorithm)
  end


  def get_jwt_payload(token)
    token = token.to_s[7..]
    begin
      payload = JWT.decode(token, @@secret_key, @@algorithm)
    rescue JWT::ExpiredSignature
      return { 'err' => 410 }
    rescue JWT::DecodeError
      return nil
    end
    payload[0]
  end
end
