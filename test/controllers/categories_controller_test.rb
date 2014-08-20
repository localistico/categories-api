require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test 'index' do
    get :index
    assert_response :success
  end

  test 'first suggestions' do
    get :suggestions
    assert_response :success
    categories = assigns(:categories)
    assert_equal Category.base.all, categories
    assert categories.size > 1, 'No categories'
  end

  test 'limit suggestions' do
    get :suggestions, limit: 3
    assert_response :success
    categories = assigns(:categories)
    assert_equal 3, categories.size
  end

  test 'limit suggestions and skip ignored' do
    ignored_ids = Category.base.limit(3).all.map(&:id)
    get :suggestions, limit: 3, ignored: ignored_ids
    assert_response :success
    categories = assigns(:categories)
    assert_equal 3, categories.size
    categories.each do |category|
      assert !ignored_ids.include?(category.id), 'Category not ignored'
    end
  end

  test 'suggestions with selections' do
    selected = Category.find(2)
    get :suggestions, selected: [selected.id], limit: 5
    assert_response :success
    categories = assigns(:categories)
    assert_equal 5, categories.size
    categories.each do |category|
      assert_equal selected.id, category.parent_id
    end
  end

  test 'suggestions not expanded if no limit is provied' do
    selected = Category.find(2)
    get :suggestions, selected: [selected.id]
    assert_response :success
    categories = assigns(:categories)
    assert_equal selected.children.size, categories.size
    categories.each do |category|
      assert_equal selected.id, category.parent_id
    end
    assert_equal selected.children, categories
  end

  test 'suggestions expands to try to fill limit' do
    selected = Category.find(2)
    get :suggestions, selected: [selected.id], limit: 20
    assert_response :success
    categories = assigns(:categories)
    assert_equal 17, categories.size
  end

  test 'suggestions expansion does not go over limit' do
    selected = Category.find(2)
    get :suggestions, selected: [selected.id], limit: 13
    assert_response :success
    categories = assigns(:categories)
    assert_equal 13, categories.size
  end

  test 'normalized with no categories' do
    get :normalized
    assert_response :success
    assert_equal 0, assigns(:categories).size
  end

  test 'normalized with unassigned categories' do
    ServiceCategory.create!(category: 'this', service: 'foursquare')
    assert_difference 'ServiceCategory.count', 1 do
      get :normalized, service_categories: { foursquare: %w(this that) }
      assert_response :success
      assert_equal 0, assigns(:categories).size
    end
  end

  test 'normalized with assigned categories' do
    ServiceCategory.create!(
      category: 'this',
      service: 'foursquare',
      category_id: 3
    )
    assert_difference 'ServiceCategory.count', 1 do
      get :normalized, service_categories: { foursquare: %w(this that) }
      assert_response :success
      assert_equal 1, assigns(:categories).size
      assert_equal 3, assigns(:categories).first.id
    end
  end

  test 'index with ids' do
    ids = [2, 3, 5, 7]
    get :index, ids: ids
    assert_response :success
    assert_equal ids, assigns(:categories).map(&:id)
  end
end
