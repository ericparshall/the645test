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
  ActiveRecord::Base.transaction do
    next if klass.exists?
    rows = CSV.parse(File.read(Rails.root.join("db/bulk_data/#{file_name}.csv")).scrub, headers: true).map {|row| row.to_h }
    klass.create_with(created_at: Time.now, updated_at: Time.now).insert_all(rows)
    p "#{klass.count} rows inserted"
  end
end

p "Phew, all done!"
