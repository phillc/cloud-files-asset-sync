namespace :cf_asset_host do
  desc "Syncs the public directory with Rackspace cloud files"
  task :default, :roles => :app, :only => {:asset_host_syncer => true} do
    `rake cf_asset_host`
  end
end