class User < ApplicationRecord
  has_many :pinned_locations
  has_many :trip_likes, :foreign_key => :trip_liker_id
  has_many :liked_trips, through: :trip_likes
  has_many :created_trips, :foreign_key => :creator_id, :class_name => "Trip"


  # validations
  validates :username, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true

  has_secure_password

end
