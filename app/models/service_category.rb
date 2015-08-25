# ServiceCategories
class ServiceCategory < ActiveRecord::Base
  belongs_to :assigned, class_name: 'Category', foreign_key: 'category_id'

  validates :service, presence: true
  validates_inclusion_of :service, in: %w(foursquare facebook google yelp bing)
  validates :category, presence: true
  validates_uniqueness_of :category, scope: :service

  after_validation :report_validation_errors_to_rollbar
  after_save :update_other_categories, if: :category_id_changed?

  default_scope { order(:category) }

  scope :pending,    -> { where(category_id: nil) }
  scope :assigned,   -> { where.not(category_id: nil) }
  scope :bing,       -> { where(service: 'bing') }
  scope :facebook,   -> { where(service: 'facebook') }
  scope :foursquare, -> { where(service: 'foursquare') }
  scope :google,     -> { where(service: 'google') }
  scope :yelp,       -> { where(service: 'yelp') }

  def update_other_categories
    return unless category_id
    ServiceCategory
      .where(category: category)
      .update_all(category_id: category_id)
  end

  def name
    [service, category].join(' - ')
  end
end
