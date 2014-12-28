module Hikkoshi::Jekyll
  module PostProcessor
    module Date
      private
      def date_from_filename(filename)
        basename = File.basename(filename, ".*")
        extracted = basename.match(/^(\d\d\d\d-\d\d-\d\d)/)[1]

        if extracted.empty?
          return nil
        else
          return parse_time(extracted)
        end
      end
    end
  end
end
