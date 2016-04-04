# == Schema Information
#
# Table name: friends
#
#  id                   :integer          not null, primary key
#  username             :string
#  name                 :string
#  bio                  :text
#  website              :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  uid                  :string
#  avatar_file_name     :string
#  avatar_content_type  :string
#  avatar_file_size     :integer
#  avatar_updated_at    :datetime
#  instagram_avatar_url :string
#
# Indexes
#
#  index_friends_on_uid       (uid)
#  index_friends_on_username  (username)
#

class Friend < ActiveRecord::Base

  has_many :results
  has_many :users, :through => :results
  has_attached_file :avatar,
    :styles => { :thumb => "80x80^" },
    :convert_options => { :thumb => "-quality 75 -strip" },
    :use_timestamp => false,
    :s3_protocol => "https"

  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  def set_avatar
    self.avatar = URI.parse(instagram_avatar_url)
    save!
  end

  def avatar_url
    avatar? ? avatar(:thumb) : instagram_avatar_url
  end

end
