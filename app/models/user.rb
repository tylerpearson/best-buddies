# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  email                    :string
#  username                 :string
#  name                     :string
#  provider                 :string
#  uid                      :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  avatar                   :string
#  bio                      :text
#  website                  :string
#  auth_token               :string
#  has_results              :boolean          default(FALSE)
#  share_image_url          :string
#  avatar_file_name         :string
#  avatar_content_type      :string
#  avatar_file_size         :integer
#  avatar_updated_at        :datetime
#  share_image_file_name    :string
#  share_image_content_type :string
#  share_image_file_size    :integer
#  share_image_updated_at   :datetime
#  shared                   :boolean
#  popular                  :boolean          default(FALSE)
#
# Indexes
#
#  index_users_on_shared  (shared)
#

class User < ActiveRecord::Base

  # validates :email, presence: true, uniqueness: true
  validates :username, uniqueness: true, if: 'username.present?'

  has_many :results, dependent: :destroy
  has_many :friends, :through => :results, dependent: :destroy

  has_attached_file :share_image,
    :styles => { :thumb => "" },
    :convert_options => { :thumb => '-quality 100' },
    :use_timestamp => false,
    :s3_protocol => "https",
    :url => "/system/:hash.:extension",
    :hash_secret => "ddd61e54eb166dcc00bda7e1ac1ad29cf7e8cfd15672c9e12e18b44b1dc5cd908887402de538dad29ec5a8b515be1342d9fc6cd24c4f7c9f3a05cc6ceacc613a",
    :default_style => :thumb

  validates_attachment :share_image, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

  def top_results
    results.order(like_count: :desc).limit(10).includes(:friend)
  end

  def top_friends
    Friend.where("id in (?)", top_results.pluck(:friend_id)).all
  end

  def save_top_friends_avatars
    top_friends.each do |friend|
      friend.set_avatar
    end
  end

end
