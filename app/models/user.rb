# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token
  mount_uploader :avatar, AvatarUploader
  has_many :lessons, dependent: :destroy
  has_many :following_relationships,  class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'following_id', dependent: :destroy

  def follow(user)
    following_relationships.create(following_id: user.id)
  end

  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  def following?(user)
    following.include?(user)
  end

  has_many :following, through: :following_relationships, source: :following
  has_many :followers, through: :follower_relationships, source: :follower

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :fullname, presence: true
  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
