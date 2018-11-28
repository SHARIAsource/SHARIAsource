namespace :editors do
  desc "Sends email to inactive editors"
  task :notify_inactive => :environment do
    NotifyInactiveEditorsWorker.perform_async
  end
end
