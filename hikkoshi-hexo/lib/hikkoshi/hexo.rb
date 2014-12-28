require "hikkoshi/hexo/version"

require "hikkoshi/jekyll"

module Hikkoshi
  module Hexo
    autoload :Post, "hikkoshi/hexo/post"
    autoload :Importer, "hikkoshi/hexo/importer"
    autoload :Exporter, "hikkoshi/hexo/exporter"
  end
end
