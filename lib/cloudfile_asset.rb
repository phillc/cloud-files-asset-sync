require 'cloudfiles'
require 'yaml'

module CloudfileAsset
  class << self
    def get_local_public_path
      "#{RAILS_ROOT}/public/"
    end
    
    def get_container
      cloud_config = YAML.load_file("#{RAILS_ROOT}/config/cloud_files.yml")['production'].symbolize_keys
      
      cf = CloudFiles::Connection.new(cloud_config[:username], cloud_config[:api_key])
      container = cf.container(cloud_config[:assets_container])
      return container
    end
    
    def get_local_public_files
      files = Dir[[self.get_local_public_path, '**/*.*'].join].reject do |file|
        extension = file.split('.').last
        case extension
        when 'cgi', 'fcgi', 'rb', 'sass'
          true
        else
          false
        end
      end
      return files
    end
    
    def sync_public(loud=false, wait=nil)
      container = self.get_container
      files = self.get_local_public_files
      
      begin_time = Time.new
      files.each do |file|
        if loud
          start = Time.new
          puts "uploading file - #{file}"
        end

        object = container.create_object(file.split(@dir_path).last, false)
        object.load_from_filename(file)
        
        if loud
          now = Time.new
          diff =  now - start
          total = now - begin_time
          puts "done uploading file - #{file} - #{diff} sec, #{total}"
        end
        
        sleep wait.to_i if not wait.nil?
      end
      puts "Done uploading"
    end
    
    def test
      container = self.get_container
      puts (container.objects - self.get_local_public_files)
    end
  end
end