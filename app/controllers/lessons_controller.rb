# frozen_string_literal: true

class LessonsController < ApplicationController
  before_action :find_lesson, only: [:show, :update, :result]
  def show
  end

  def create
    @category = Category.find(params[:category_id])

    @lesson = Lesson.new(category: @category)
    @lesson = @category.lessons.new(user: current_user)
    if @lesson.save
      words = @category.words.sample(10)
      @lesson.words = words
      flash[:success] = 'Welcome to lesson'
      redirect_to @lesson
    else
      flash[:danger] = "Create lesson failed"
      redirect_to root_path
    end
  end

  def update
    if @lesson.update_attributes(lesson_params)
      redirect_to result_lesson_path(@lesson)
    else
      render :show
    end
  end

  def result
    @category = @lesson.category
  end

  private
    def lesson_params
      params.require(:lesson).permit lesson_words_attributes: [:id, :word_answers_id]
    end

    def find_lesson
      @lesson = Lesson.find(params[:id])
    end
end
