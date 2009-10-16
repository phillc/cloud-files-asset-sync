module CloudfileAsset
  module LocalFile
    class << self
      def make_relative(filename)
        filename.split(self.get_local_public_path).last
      end
    end
  end
end