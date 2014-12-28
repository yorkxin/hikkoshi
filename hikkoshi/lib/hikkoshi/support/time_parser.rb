require "time"

module Hikkoshi::Support
  module TimeParser
    def parse_time(time)
      # Assume local time zone
      Time.parse(time) rescue nil
    end
  end
end
