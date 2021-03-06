class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work
  has_many :works

  # validates :username, uniqueness: true, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
  validates :email, presence: true

  def self.create_from_github(auth_hash)
    user = User.new

    if auth_hash["uid"] == nil || auth_hash["provider"] == nil || auth_hash["info"] == nil
    return nil
    end

    user.uid = auth_hash["uid"]
    user.provider = auth_hash["provider"]
    user.email = auth_hash["info"]["email"]
    user.save
    user.username = auth_hash["info"]["name"] || "User#{user.id}"
    user.save ? user : nil
  end

end
