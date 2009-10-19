desc "Sync public folder with cloud files"
task :cf_asset_host => "cf_asset_host:sync"

namespace :cf_asset_host do
  task :sync => :environment do
    CloudfileAsset::Sync.public(loud=true, wait=ENV['wait'])
  end
  
  task :delete => :environment do
    CloudfileAsset::Sync.delete_all(loud=true)
  end
  
  task :resync => ["delete", "sync"]
end