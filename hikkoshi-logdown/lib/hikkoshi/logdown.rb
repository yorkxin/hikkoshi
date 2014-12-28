require "hikkoshi/logdown/version"

require "hikkoshi/jekyll"

module Hikkoshi
  module Logdown
    autoload :Post, "hikkoshi/logdown/post"
    autoload :Importer, "hikkoshi/logdown/importer"
  end
end
