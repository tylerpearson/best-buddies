# == Schema Information
#
# Table name: results
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  friend_id   :integer
#  like_count  :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  total_count :integer          default(0)
#
# Indexes
#
#  index_results_on_friend_id  (friend_id)
#  index_results_on_user_id    (user_id)
#

class Result < ActiveRecord::Base

  belongs_to :friend
  belongs_to :user

  validates :friend_id, uniqueness: { scope: :user_id }

end
