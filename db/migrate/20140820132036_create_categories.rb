class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.boolean :abstract
      t.string :en
      t.string :es

      t.timestamps
    end
  end
end
