# Base categories
class Category < ActiveRecord::Base
  belongs_to :parent, class_name: 'Category', foreign_key: 'parent_id'
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  scope :base, -> { where(parent_id: 1) }

  validates :es, presence: true
  validates :en, presence: true
  validates_uniqueness_of :es, scope: :parent_id
  validates_uniqueness_of :en, scope: :parent_id
end
