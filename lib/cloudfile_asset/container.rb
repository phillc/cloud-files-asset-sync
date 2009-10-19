module CloudfileAsset
  class Container
    def config
      @config ||= YAML.load_file("#{RAILS_ROOT}/config/cloud_files.yml")['production'].symbolize_keys
    end

    def container
      @container ||=  CloudFiles::Connection.new(config[:username], config[:api_key]).container(config[:assets_container])
    end

    def upload_file(filename)
      object = @container.create_object(CloudfileAsset::Local.make_relative(filename), false)
      object.load_from_filename(filename)
    end
    
    def delete_file(filename)
      @container.delete_object(filename)
    end
  
    def deleted_files
      local = CloudfileAsset::Local.public_files.collect{|filename| CloudfileAsset::Local.make_relative(filename)}
      remote = self.container.objects
    
      deleted_files = remote - local
    end
  
    def new_files
      local = CloudfileAsset::Local.public_files.collect{|filename| CloudfileAsset::Local.make_relative(filename)}
      remote = self.container.objects
    
      new_files = local - remote
    end
  end
end