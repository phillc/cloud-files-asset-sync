desc "Sync public folder with cloud files"

namespace :cf_asset_host do
  task :default => :environment do
    CloudfileAsset::sync_public
  end
  task :loud => :environment do
    CloudfileAsset::sync_public(loud=true)
  end
end