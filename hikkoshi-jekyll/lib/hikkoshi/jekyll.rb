require "hikkoshi/jekyll/version"

require "yaml"

require "hikkoshi"

module Hikkoshi
  module Jekyll
    autoload :Post, "hikkoshi/jekyll/post"
    autoload :Tag, "hikkoshi/jekyll/tag"
    autoload :Exporter, "hikkoshi/jekyll/exporter"
    autoload :Importer, "hikkoshi/jekyll/importer"

    module PostProcessor
      autoload :Date, "hikkoshi/jekyll/post_processor/date"
      autoload :Slug, "hikkoshi/jekyll/post_processor/slug"
    end
  end
end
