# frozen_string_literal: true

class Lesson < ApplicationRecord
  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words
  has_many :word_answers, through: :lesson_words
  belongs_to :user
  belongs_to :category

  accepts_nested_attributes_for :lesson_words

  validates :user_id, presence: true
  validates :category_id, presence: true

  def correct_answers
    word_answers.where(correct: true)
  end
end
