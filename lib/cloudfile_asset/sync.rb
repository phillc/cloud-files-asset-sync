module CloudfileAsset
  module Sync
    class << self
      def public(loud=false, wait=nil)
        container = CloudfileAsset::Container.new
        local_files = CloudfileAsset::Local.public_files
        deleted_files = container.deleted_files
        begin_time = Time.new

        local_files.each do |file|
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
        puts "Done uploading"
        
        deleted_files.each do |file|
          container.delete_file(file)
        end
        puts "Done cleaning up"
      end
    end
  end
end