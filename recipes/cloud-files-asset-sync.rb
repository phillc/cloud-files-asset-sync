namespace :cf_asset_host do
  desc "Syncs the public directory with Rackspace cloud files"
  task :default, :roles => :web, :only => {:asset_host_syncer => true} do
    rake = fetch(:rake, "rake")
    rails_env = fetch(:rails_env, "production")
    #maybe we should run this locally...
    run "cd #{current_path}; #{rake} RAILS_ENV=#{rails_env} cf_asset_host" do |channel, stream, data|
      puts data
    end
  end
end