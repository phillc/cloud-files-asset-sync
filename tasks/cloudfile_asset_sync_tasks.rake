desc "Sync public folder with cloud files"
task :cf_asset_host => :environment do
  CloudfileAsset::sync_public(loud=ENV['loud'], wait=ENV['wait'])
end
