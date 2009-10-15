require 'cloudfiles'
require 'YAML'

module CloudfileAsset
  class << self
    def sync_public
      cloud_config = YAML.load_file("#{RAILS_ROOT}/config/cloud_files.yml")['production'].symbolize_keys
      
      cf = CloudFiles::Connection.new(cloud_config[:username], cloud_config[:api_key])
      container = cf.container(cloud_config[:assets_container])
          
      @dir_path = "#{RAILS_ROOT}/public/"

      files = Dir[[@dir_path, '**/*.*'].join].reject do |file|
        extension = file.split('.').last
        case extension
        when 'cgi', 'fcgi', 'rb', 'sass'
          true
        else
          false
        end
      end
       
      files.each do |file|
        object = container.create_object(file.split(@dir_path).last, true)
        object.write(file)
      end
    end
  end
end