module CloudfileAsset
  module Sync
    class << self
      def sync_public(loud=false, wait=nil)
        sync = Syncer.new
      
        container = self.get_container
        files = self.get_local_public_files
      
        begin_time = Time.new
        files.each do |file|
          if loud
            start = Time.new
            puts "uploading file - #{file}"
          end

          object = container.create_object(self.make_relative(file), false)
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
  end
end