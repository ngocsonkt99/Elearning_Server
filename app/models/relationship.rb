# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :follower, foreign_key: :follower_id, class_name: "User", inverse_of: :following_relationships
  belongs_to :following, foreign_key: :following_id, class_name: "User", inverse_of: :follower_relationships

  validates :follower_id, presence: true
  validates :following_id, presence: true
end
