namespace :cf_asset_host do
  desc "Syncs the public directory with Rackspace cloud files"
  task :default, :roles => :web, :only => {:asset_host_syncer => true} do
    rake = fetch(:rake, "rake")
    rails_env = fetch(:rails_env, "production")
    run "cd #{current_path}; #{rake} RAILS_ENV=#{rails_env} cf_asset_host"
  end
end