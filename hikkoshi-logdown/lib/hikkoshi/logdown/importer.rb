module Hikkoshi::Logdown
  class Importer < Hikkoshi::Jekyll::Importer
    private
    def read_posts
      Dir.glob(File.join(@path, EXTENSIONS)).map {|filename|
        Hikkoshi::Logdown::Post.new(filename)
      }
    end
  end
end
