class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.string :screenshot
      t.text :content
      t.string :website
      t.string :repository
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
