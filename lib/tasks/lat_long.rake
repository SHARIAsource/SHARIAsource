desc "Regional Coordinates"
  namespace :coords do
	task :get => [:environment] do
	  LatLongImporter.update_all
  end
end
