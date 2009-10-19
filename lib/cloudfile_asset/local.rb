module CloudfileAsset
  module Local
    class << self
      def public_files
        files = Dir[[CloudfileAsset::LOCAL_PUBLIC_PATH, '**/*.*'].join].reject do |file|
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
      def make_relative(filename)
        filename.split(CloudfileAsset::LOCAL_PUBLIC_PATH).last
      end
    end
  end
end