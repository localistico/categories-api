class CreateServiceCategories < ActiveRecord::Migration
  def change
    create_table :service_categories do |t|
      t.integer :category_id
      t.string :service
      t.string :category

      t.timestamps
    end
  end
end
