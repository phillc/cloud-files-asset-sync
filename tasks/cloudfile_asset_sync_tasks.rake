desc "Sync public folder with cloud files"
task :cf_asset_host => "cf_asset_host:default"

namespace :cf_asset_host do
  task :default => :environment do
    CloudfileAsset::sync_public(loud=ENV['loud'], wait=ENV['wait'])
  end
  
  task :test => :environment do
    CloudfileAsset::test
  end
end