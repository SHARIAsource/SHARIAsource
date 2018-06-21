require "fileutils"
require "csv"
require 'ostruct'

module LatLongImporter
  def self.update_all
    import_coords('regions_coords.csv')
  end

  def self.import_coords(coord_csv)
    @csv_file = Rails.root.to_s + "/db/import_data/#{coord_csv}"

    def self.import_file
      File.read(@csv_file)
    end

    def self.rows
      @rows ||= CSV.parse(import_file, headers: true)
    end

    def self.find_and_update_region(name, latitude, longitude)
      puts "#{name} is updating"
      region = Region.find_by_name name
      region.update_attributes(latitude: latitude, longitude: longitude)
    end

    def self.create_struct_from_row(r)
      struct = OpenStruct.new
      struct.name = r.fetch('name')
      struct.latitude = r.fetch('latitude')
      struct.longitude = r.fetch('longitude')
      struct
    end

    def self.update_regions_from_row(r)
      struct = create_struct_from_row(r)

      region = find_and_update_region(struct.name, struct.latitude, struct.longitude)
      region.inspect
    end

    rows.each_with_index do |r, i|
      begin
        update_regions_from_row(r)
      rescue Exception => e
        puts "Error importing latitude/longitude #{e}"
      end
    end
  end
end
