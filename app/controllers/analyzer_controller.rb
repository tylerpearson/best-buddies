class AnalyzerController < ApplicationController

  before_action :set_user, except: [:results_small, :results]
  before_action :authenticate_user!, except: [:results, :results_small]

  def process_import
    if @user.has_results?
      redirect_to results_path(@user.username)
    else
      FriendsAnalyzerJob.perform_later(@user.id)
      redirect_to processing_path
    end
  end

  def processing
    session[:verified] = false
  end

  def results
    @user = User.find_by_username(params[:username])

    return redirect_to :root if @user.nil?

    if user_signed_in? && current_user.username == @user.username
      @same_user = true
    else
      @same_user = false
    end

    if user_signed_in? && current_user.username == @user.username && session[:verified] == false && !current_user.email?
      @verified = false
    else
      @verified = true
    end

    @results_user = User.where(username: params[:username]).first

    return redirect_to :root if @results_user.nil?

    @results = User.where(username: params[:username]).first.top_results
  end

  def results_small
    @results_user = User.where(username: params[:username]).first
    @results = User.where(username: params[:username]).first.top_results
  end

  def results_image
    image_link = User.where(username: params[:username]).first.share_image.url(:thumb)
    file = open(image_link)
    send_file(file, :filename => "#{params[:username]}-sweeble.png", :type => 'image/png', :disposition => 'attachment')
  end

  private

    def set_user
      @user = current_user
    end

end
