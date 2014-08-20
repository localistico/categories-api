require 'open-uri'

base_url='https://raw.githubusercontent.com/Factual/places'
FACTUAL_CATEGORIES_URL="#{base_url}/master/categories/factual_taxonomy.json"

namespace :factual do
  desc 'Fetch factual categories'
  task :fetch do
    open(FACTUAL_CATEGORIES_URL) do |c|
      File.open(Rails.root.join('db/factual_categories.json'), 'w') do |f|
        f.write(c.read)
      end
    end
  end
end
