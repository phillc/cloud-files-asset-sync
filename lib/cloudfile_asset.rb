require 'cloudfiles'
require 'yaml'
require 'cloudfile_asset/sync'
require 'cloudfile_asset/local'
require 'cloudfile_asset/container'

module CloudfileAsset
  # defined?(Rails.public_path) ? Rails.public_path : "public"
  LOCAL_PUBLIC_PATH = "#{RAILS_ROOT}/public/"
end