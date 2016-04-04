require 'instagram'

class FriendsAnalyzer

  def initialize(user_id)
    @user = User.find(user_id)
    @client = Instagram.client(:access_token => @user.auth_token)
    @friends_info = {}
    @friends_count = Hash.new(0)
    @media_count = 0
  end

  def process

    # go back 60
    page_1 = @client.user_recent_media
    page_2_max_id = page_1.try(:pagination).try(:next_max_id) || nil
    page_2 = @client.user_recent_media(:max_id => page_2_max_id) unless page_2_max_id.nil?
    page_3_max_id = page_2.try(:pagination).try(:next_max_id) || nil
    page_3 = @client.user_recent_media(:max_id => page_3_max_id) unless page_3_max_id.nil?

    recent_media = [page_1, page_2, page_3].compact.reduce(:+)
    @media_count = recent_media.length

    recent_media.each do |item|
      if item.likes['count'] > 0
        if item.likes['count'].to_i > 110
          @user.popular = true
        end

        like_info = @client.media_likes(item.id)
        registered = 0

        like_info.each do |liker|
          unless @friends_info.has_key?(liker.username)
            @friends_info[liker.username] = liker
          end
          @friends_count[liker.username] += 1
          registered += 1
        end
      end
    end

    save_results
  end

  def friends_count
    @friends_count.sort_by{|k,v| v}.reverse.to_h
  end

  def top_friends_count
    @friends_count.sort_by { |k, v| v }.reverse.take(10).to_h
  end

  def friends_info
    @friends_info
  end

  private

    def save_results
      friends_count.each do |friend_username, count|
        friend = Friend.find_or_create_by(username: friend_username)
        friend.uid = @friends_info[friend_username]['id'] || ''
        friend.instagram_avatar_url = @friends_info[friend_username]['profile_picture'] || ''
        friend.bio = @friends_info[friend_username]['bio'] || ''
        friend.name = @friends_info[friend_username]['full_name'] || ''
        friend.save!
        result = Result.create(user_id: @user.id, friend_id: friend.id, like_count: count, total_count: @media_count)
      end
      @user.has_results = true
      @user.save
      Screenshotter.delay.new(@user.id)
      @user.delay.save_top_friends_avatars
    end

end
