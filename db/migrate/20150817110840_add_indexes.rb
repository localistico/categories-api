class AddIndexes < ActiveRecord::Migration
  def change
    add_index :service_categories, :category_id
    add_index :service_categories, :service
  end
end
