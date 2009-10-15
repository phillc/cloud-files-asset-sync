require 'cloudfiles'
require 'yaml'

module CloudfileAsset
  class << self
    def sync_public(loud=false, wait=nil)
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
        if loud
          start = Time.new
          puts "uplading file - #{file}"
        end
        object = container.create_object(file.split(@dir_path).last, true)
        object.write(file)
        if loud
          diff = Time.new - start
          puts "done uploading file - #{file} - #{diff} sec"
        end
        sleep wait.to_i if not wait.nil?
      end
    end
  end
end