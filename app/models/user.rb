# User model for the database. This model is used to store user information
class User < ApplicationRecord
  has_many :party_users
  has_many :parties, through: :party_users

  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :email, case_sensitive: false

  has_secure_password
  
  def hosted_parties
    parties.where(host_id: id)
  end

  def invited_to_parties
    parties.where.not(host_id: id)
  end
end
