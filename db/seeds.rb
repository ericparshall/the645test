require 'csv'

class_file_pairings = { 
  'crunchbase-companies' => CrunchbaseCompany,
  'crunchbase-acquisitions' => CrunchbaseAcquisition,
  'crunchbase-rounds' => CrunchbaseRound,
  'crunchbase-investments' => CrunchbaseInvestment
}.freeze

p "Loading Crunchbase data (this could take a while!)"

class_file_pairings.each do |file_name, klass|
  p "...#{file_name}"
  rows = CSV.parse(File.read(Rails.root.join("db/bulk_data/#{file_name}.csv")).scrub, headers: true)
  rows.each { |row| klass.find_or_create_by(row.to_h) }
end

p "Phew, all done!"
