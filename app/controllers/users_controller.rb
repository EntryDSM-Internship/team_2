class UsersController < ApplicationController
  before_action :jwt_init

  def show

  end

  def show_many

  end

  def create
    return render status: 400 if params[:email].blank? || params[:name].blank?
    return render status: 409 if User.find_by_email(params[:email])

    auth_code = create_auth_code
    overlap = TempUser.find_by_email(params[:email])

    if overlap
      overlap.name = params[:name]
      overlap.auth_code = auth_code
      overlap.save
    else
      temp_user = TempUser.new
      temp_user.email = params[:email]
      temp_user.name = params[:name]

      temp_user.auth_code = auth_code
      temp_user.save
    end

    AuthMailer.send_auth_code(params[:email],
                              'MINITWEEET에서 인증번호가 도착했습니다.',
                              auth_code).deliver_later
    render status: 204
  end

  def emailcheck_get
    return render status: 400 if params[:email].blank?

    if User.find_by_email(params[:email])
      render status: 204
    else
      render status: 409
    end
  end

  def emailcheck_post
    return render status: 400 if params[:authCode].blank?

    temp_user = TempUser.find_by_auth_code(params[:authCode])
    if temp_user
      temp_user.verified = true
      temp_user.save
      render json: { tempUserId: temp_user.id }, status: 200
    else
      render status: 403
    end
  end

  def create_complete
    if params[:tempUserId].blank? || params[:password].blank?
      return render status: 400
    end

    temp_user = TempUser.find_by_id(params[:tempUserId])
    return render status: 404 if temp_user.nil?

    if temp_user.verified
      create_user(temp_user)
      render status: 201
    else
      render status: 403
    end
  end

  def edit_emailcheck

  end

  def edit_emailcheck_complete

  end

  def update

  end

  private

  def create_user(temp_user)
    User.create!(name: temp_user.name,
                 email: temp_user.email,
                 password: params[:password],
                 profile_img: '')
    temp_user.destroy
  end
end
