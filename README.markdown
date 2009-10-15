CloudfileAssetSync
==================
This plugin is intended to allow for easy movement of assets (rails public folder) to Rackspace's cloud files.

Dependencies
==================

Requires rackspace cloudfiles gem
[http://github.com/rackspace/ruby-cloudfiles/tree](http://github.com/rackspace/ruby-cloudfiles/tree)

Usage:
==================
In your RAILS_ROOT/config folder, create a cloud_files.yml .
The config file is compatible with Minter's paperclip fork for cloud files [http://github.com/minter/paperclip](http://github.com/minter/paperclip)

cloud_files.yml:

    development:
      username: -- username --
      api_key: -- api_key --
      container: -- container -- # for paperclip
    production:
      username: -- username --
      api_key: -- api_key --
      container: -- container -- # for paperclip
      assets_container: -- container name of where your public assets will go --
    
Usage:
  rake cf_asset_host
    
Will publish capistrano recipe when I finish it.


Copyright (c) 2009 [phillc](http://kapsh.com), released under the MIT license
