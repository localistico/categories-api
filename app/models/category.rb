# Base categories
class Category < ActiveRecord::Base
  belongs_to :parent, class_name: 'Category', foreign_key: 'parent_id'

  validates :es, presence: true
  validates :es, uniqueness: true
  validates :en, presence: true
  validates :en, uniqueness: true
end
