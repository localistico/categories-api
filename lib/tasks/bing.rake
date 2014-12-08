require 'csv'

BING_FILE = ENV['BING_FILE'] || 'db/bing_categories.csv'

namespace :bing do
  desc 'Load Bing categories'
  task load: :environment do
    name_key, _ = %w(CategoryName CategoryId)
    puts "Loading categories from #{BING_FILE}"
    CSV.foreach(BING_FILE, headers: :first_row) do |c|
      fail 'Missing Catgory' if c[name_key].blank?
      print '.'
      category = ServiceCategory.new(service: 'bing', category: c[name_key])
      category.save
    end
  end
end
