CloudfileAssetSync
==================
This plugin is intended to allow for easy movement of assets (rails public folder) to Rackspace's cloud files.

Dependencies
==================

Requires rackspace cloudfiles gem
[http://github.com/rackspace/ruby-cloudfiles/tree](http://github.com/rackspace/ruby-cloudfiles/tree)

For the present, requires this patch to be ran on the gem
        diff --git a/lib/cloudfiles/container.rb b/lib/cloudfiles/container.rb
        index 650658b..e3827e1 100644
        --- a/lib/cloudfiles/container.rb
        +++ b/lib/cloudfiles/container.rb
        @@ -167,7 +167,7 @@ module CloudFiles
               doc = REXML::Document.new(response.body)
               detailhash = {}
               doc.elements.each("container/object") { |o|
        -        detailhash[o.elements["name"].text] = { :bytes => o.elements["bytes"].text, :hash => o.elements["hash"].text, :content_type => o.elements["content_type"].text, :last_modified => Time.parse(o.elements["last_modified"].text) }
        +        detailhash[o.elements["name"].text] = { :bytes => o.elements["bytes"].text, :hash => o.elements["hash"].text, :content_type => o.elements["content_type"].text, :last_modified => DateTime.parse(o.elements["last_modified"].text) }
               }
               doc = nil
               return detailhash


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
    
TODO:
================
- Capistrano Recipie
- Delete files that no longer exist
- Gem Time vs DateTime work around without patch


Copyright (c) 2009 [phillc](http://kapsh.com), released under the MIT license
