# Script to load factual categories into the database

class FactualCategoryLoader
  def initialize(src = Rails.root.join('db/factual_categories.json'))
    open(src) do |f|
      @categories = JSON.parse(f.read)
    end
    verify!
  end

  def categories
    @categories.map do |id, content|
      {
        id: id.to_i,
        parent_id: content['parents'].first.try(:to_i),
        es: content['labels']['es'],
        en: content['labels']['en'],
        abstract: content['abstract']
      }
    end
  end

  def verify!
    @errors = []
    ids = @categories.keys.map(&:to_i)
    @erros << 'ids must be unique' if ids.uniq != ids
    @categories.each do |id, content|
      @erros << "#{id} is not a integer" if id.to_i.to_s != id
      @erros << "#{id} has more than one parent" if content['parents'].size > 1
      @erros << "#{id} missing es label" if content['labels']['es'].blank?
      @erros << "#{id} missing en label" if content['labels']['es'].blank?
    end
    fail @errors unless @errors.empty?
  end
end

def verify_label_did_not_change(locale, own_category, factual_category)
  error_msg = '%s label changed: %s => %s'
  locale = locale.to_sym
  current = own_category.send(locale)
  new_label = factual_category[locale]
  fail format(error_msg, locale, current, new_label) if current != new_label
end

loader = FactualCategoryLoader.new
loader.categories.each do |category|
  begin
    id = category[:id]
    own_category = Category.find(id)
    [:es, :en].each do |label|
      verify_label_did_not_change(label, own_category, category)
    end
    fail "#{id} parent change" if own_category.parent_id != category[:parent_id]
  rescue ActiveRecord::RecordNotFound
    own_category = Category.new(category)
    own_category.save!
  end
end
