class Screenshotter

  MAX_ATTEMPTS = 5


  def initialize(user_id)
    @user = User.find(user_id)
    take_screenshot
  end

  def take_screenshot
    if @user.has_results && !@user.share_image_url

      if Rails.env.production?
        output = `vendor/phantomjs/bin/phantomjs phantomjs/screenshotter.js https://instabuddies.herokuapp.com/results/#{@user.username}/small #{@user.username}`
      else
        output = `bin/phantomjs phantomjs/screenshotter.js http://localhost:5000/results/#{@user.username}/small #{@user.username}`
      end

      puts output

      file_path = "tmp/#{@user.username}.jpg"

      count = 0
      until File.exists?(file_path)
        count += 1
        sleep 1
        puts "somethings wrong count #{count}"
        if count > MAX_ATTEMPTS
          break
        end
      end

      puts "the path is #{file_path}"

      begin
        @user.share_image = open(file_path)
        @user.save
        File.delete(file_path)  # then delete locally
      rescue => exception
        Rails.logger.info("SOMETHING WENT WRONG WITH THE SCREENSHOTTING")
        raise "something is fucked up with the screenshotter"
      end
    end
  end

end