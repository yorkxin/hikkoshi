require "hikkoshi/ghost/version"

module Hikkoshi
  module Ghost
    autoload :Tag, "hikkoshi/ghost/tag"
    autoload :Exporter, "hikkoshi/ghost/exporter"

    module PostProcessor
      autoload :TableDowngrader, "hikkoshi/ghost/post_processor/table_downgrader"
    end
  end
end
