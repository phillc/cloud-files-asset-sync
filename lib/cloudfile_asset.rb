require 'cloudfiles'
require 'yaml'
require 'cloudfile_asset/sync'
require 'cloudfile_asset/local_file'
require 'cloudfile_asset/container'

module CloudfileAsset
  LOCAL_PUBLIC_PATH = "#{RAILS_ROOT}/public/"
end