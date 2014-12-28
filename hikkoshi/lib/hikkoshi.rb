require "hikkoshi/version"

module Hikkoshi
  autoload :Post, "hikkoshi/post"
  autoload :Tag, "hikkoshi/tag"

  autoload :Importer, "hikkoshi/importer"
  autoload :Exporter, "hikkoshi/exporter"

  module Support
    autoload :Slugify, "hikkoshi/support/slugify"
    autoload :TimeParser, "hikkoshi/support/time_parser"
  end
end
