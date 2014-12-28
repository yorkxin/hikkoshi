module Hikkoshi::Jekyll
  module PostProcessor
    module Slug
      extend Hikkoshi::Support::Slugify

      private
      def slug_from_filename(filename, strip_date: true)
        basename = File.basename(filename, ".*")

        if strip_date
          extracted = basename.sub(/^\d\d\d\d-\d\d-\d\d-/, "").strip
        else
          extracted = basename
        end

        if extracted.empty?
          return nil
        else
          return extracted
        end
      end

      def slug_from_title(title)
        slugify(title)
      end
    end
  end
end
