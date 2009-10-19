module CloudfileAsset
  module Sync
    class << self
      def public(loud=false, wait=nil)
        container = CloudfileAsset::Container.new
        new_files = container.new_files
        modified_files = container.modified_files
        deleted_files = container.deleted_files
        begin_time = Time.new

        (new_files + modified_files).each do |file|
          if loud
            start = Time.new
            puts "uploading file - #{file}"
          end

          container.upload_file(file)

          if loud
            now = Time.new
            diff =  now - start
            total = now - begin_time
            puts "done uploading file - #{file} - #{diff} sec, #{total}"
          end

          sleep wait.to_i if not wait.nil?
        end
        puts "Done uploading" if loud
        
        deleted_files.each do |file|
          container.delete_file(file)
        end
        puts "Done cleaning up" if loud
      end
      
      def delete_all(loud=false)
        container = CloudfileAsset::Container.new
        container.remote_files.each do |file|
          container.delete_file(file)
        end
        puts "Done deleteing all remote files" if loud
      end
    end
  end
end