# frozen_string_literal: true

class Admin::WordsController < ApplicationController
  before_action :find_word, only: %i[show edit update destroy]

  def index
    @words = Word.order(created_at: :desc)
  end

  def new
    @categories = Category.order(:name)
    @word = Word.new
    3.times { @word.word_answers.new }
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = 'Create word successfully'
      redirect_to admin_word_path(@word)
    else
      flash.now[:alert] = 'Create word failed'
      render :new
    end
  end

  def destroy
    @word.destroy
    flash[:success] = "Delete word successfully"
    redirect_to admin_words_path(@word)
  end

  def edit; end

  def update
    if @word.update_attributes(word_params)
      flash[:notice] = 'Updated word successfully'
      redirect_to admin_word_path(@word)
    else
      flash.now[:alert] = 'Updated word failed'
      render :edit
    end
  end

  def show
    @word_answers = @word.word_answers
  end

  private
    def word_params
      params.require(:word).permit :content, :category_id, word_answers_attributes: [:id, :content, :word_id, :correct]
    end

    def find_word
      @word = Word.find(params[:id])
    end
end
