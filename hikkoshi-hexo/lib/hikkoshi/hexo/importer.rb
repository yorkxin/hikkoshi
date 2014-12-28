module Hikkoshi::Hexo
  class Importer < Hikkoshi::Jekyll::Importer
    private
    def read_posts
      Dir.glob(File.join(@path, EXTENSIONS)).map {|filename|
        Hikkoshi::Hexo::Post.new(filename)
      }
    end
  end
end
