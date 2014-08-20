# ServiceCategories
class ServiceCategory < ActiveRecord::Base
  belongs_to :assigned, class_name: 'Category', foreign_key: 'category_id'

  validates :service, presence: true
  validates :category, presence: true
  validates_uniqueness_of :category, scope: :service
end
