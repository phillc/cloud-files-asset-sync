module Container
  class << self
    def config
      @config ||= YAML.load_file("#{RAILS_ROOT}/config/cloud_files.yml")['production'].symbolize_keys
    end

    def container
      @container ||=  CloudFiles::Connection.new(config[:username], config[:api_key]).container(config[:assets_container])
    end
  

  

  
    def upload_file(container, filename)
    
    end
  
    def get_deleted(container=nil)
      container ||= self.get_container
      local = self.get_local_public_files.collect{|filename| make_relative(filename)}
      remote = container.objects
    
      diff = remote - local
      puts diff
    end
  
    def get_new(container=nil)
      container ||= self.get_container
      local = self.get_local_public_files.collect{|filename| make_relative(filename)}
      remote = container.objects
    
      diff = local - remote
      puts diff
    end
  end
end