class SessionsController < ApplicationController

  def new
    redirect_to '/auth/instagram'
  end

  def create
    auth = request.env["omniauth.auth"]
    username = auth['info']['nickname']
    uid = auth['uid']

    if !User.where(username: auth['info']['nickname']).any?
      user = User.new
      user.provider = auth['provider']
      user.uid = uid
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.username = username || ""
         user.avatar = auth['info']['image'] || ""
         user.bio = auth['info']['bio'] || ""
         user.website = auth['info']['website'] || ""
         user.auth_token = auth['credentials']['token'] || ""
      end
      user.save
    end

    session[:user_id] = User.where(uid: uid).first.id

    redirect_to process_path, :notice => 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end