# frozen_string_literal: true

class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :content
      t.integer :category_id

      t.timestamps
    end
  end
end
