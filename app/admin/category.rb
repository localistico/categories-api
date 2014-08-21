ActiveAdmin.register Category do
  actions :index, :show

  config.batch_actions = false

  config.sort_order = 'en_asc'

  filter :parent
  filter :children
  filter :en
  filter :es
  filter :abstract

  index do
    selectable_column
    column :id
    column :abstract
    column :en
    column :es
    column :parent
  end
end
