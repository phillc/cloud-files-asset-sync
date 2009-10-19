module CloudfileAsset
  class Container
    def initialize
      config
      container
    end
    def config
      @config ||= YAML.load_file("#{RAILS_ROOT}/config/cloud_files.yml")['production'].symbolize_keys
    end

    def container
      @container ||=  CloudFiles::Connection.new(config[:username], config[:api_key]).container(config[:assets_container])
    end
    
    def local_files
      @local_files ||= CloudfileAsset::Local.public_files.collect{|filename| CloudfileAsset::Local.make_relative(filename)}
    end
    
    def remote_files
      @remote_files ||= @container.objects
    end
    
    def upload_file(filename)
      object = @container.create_object(filename, false)
      object.load_from_filename(CloudfileAsset::Local.make_absolute(filename))
    end
    
    def delete_file(filename)
      @container.delete_object(filename)
    end
    
    def new_files
      local_files - remote_files
    end
    
    def same_files
      local_files & remote_files
    end
    
    #not perfect, but could save some bandwith perhaps
    def modified_files
      remote_details = @container.list_objects_info
      same_files.reject do |file|
        (remote_details[file][:last_modified] <=> File.mtime(CloudfileAsset::Local.make_absolute(file))) == 1
      end
    end

    def deleted_files
      remote_files - local_files
    end
  end
end