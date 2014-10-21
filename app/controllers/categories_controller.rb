# Serve categories and category suggestions
class CategoriesController < ApiController
  def index
    if params[:ids]
      @categories = Category.find(params[:ids])
    else
      @categories = Category.all
    end
    respond_with @categories
  end

  def suggestions
    if params[:selected]
      selection = Category.where(parent_id: params[:selected])
    else
      selection = Category.base
    end
    selection = selection.where.not(id: params[:ignored]) if params[:ignored]
    @categories = selection.limit(params[:limit]).all
    expand_categories
    respond_with @categories
  end

  def normalized
    category_ids = []
    requested_categories = params[:service_categories] || {}
    requested_categories.each do |service, categories|
      category_ids += get_category_ids(service, categories)
    end
    category_ids.compact!
    @categories = Category.find(category_ids)
    respond_with @categories
  end

  def root
    respond_with(links: { categories: categories_path })
  end

  private

  def get_category_ids(service, categories)
    categories.map do |category|
      ServiceCategory
        .find_or_create_by(service: service, category: category)
        .category_id
    end
  end

  def expand_categories
    return unless params[:limit]
    limit = params[:limit].to_i
    to_expand = 0
    while @categories.size < limit && to_expand < @categories.size
      @categories += @categories[to_expand].children
      to_expand += 1
    end
    @categories = @categories[0..limit - 1]
  end
end
