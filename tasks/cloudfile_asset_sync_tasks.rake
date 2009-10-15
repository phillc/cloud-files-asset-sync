desc "Sync public folder with cloud files"
task :cf_asset_host => :environment do
  CloudfileAsset::sync_public
end