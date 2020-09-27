# frozen_string_literal: true

class WordAnswer < ApplicationRecord
  belongs_to :word, optional: true
  has_many :lesson_words, dependent: :destroy
  has_many :lessons, through: :lesson_words

  validates :content, presence: true, length: { maximum: 20 }
  validates :correct, inclusion: { in: [true, false] }
end
