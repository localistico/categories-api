# ServiceCategories
class ServiceCategory < ActiveRecord::Base
  belongs_to :assigned, class_name: 'Category', foreign_key: 'category_id'

  validates :service, presence: true
  validates_inclusion_of :service, in: %w(foursquare facebook google yelp)
  validates :category, presence: true
  validates_uniqueness_of :category, scope: :service

  after_validation :report_validation_errors_to_rollbar

  scope :pending, -> { where(category_id: nil) }

  def name
    [service, category].join(' - ')
  end
end
