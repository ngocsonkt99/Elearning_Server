# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.integer :target_id
      t.integer :user_id
      t.string :action_type

      t.timestamps
    end
  end
end
