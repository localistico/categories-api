ActiveAdmin.register ServiceCategory do
  actions :index, :edit, :destroy, :update

  permit_params :category_id

  before_filter only: [:index] do
    params['q'] = { category_id_null: 1 } if params['commit'].blank?
  end

  controller do
    def update
      update! do |format|
        format.html { redirect_to admin_dashboard_path }
      end
    end
  end

  filter :category_id_null,
         as: :boolean,
         label: 'Pending assignation'
  filter :service, as: :select
  filter :category
  filter :assigned, multiple: true

  scope :all
  scope :pending
  scope :assigned
  scope :bing
  scope :facebook
  scope :foursquare
  scope :google
  scope :yelp

  index do
    selectable_column
    column :service
    column :category do |c|
      link_to c.category, edit_admin_service_category_path(c)
    end
    column :assigned
    actions
  end

  show do
    attributes_table do
      row :service
      row :category
      row :assigned
    end
  end

  form partial: 'admin/edit_service_category'
end
