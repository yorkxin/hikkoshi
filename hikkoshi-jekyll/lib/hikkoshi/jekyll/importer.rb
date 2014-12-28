module Hikkoshi::Jekyll
  class Importer < Hikkoshi::Importer
    EXTENSIONS = "*.{md,markdown,mkdn}"

    def initialize(path)
      @path = File.expand_path(path)

      @posts = read_posts
    end

    private
    def read_posts
      Dir.glob(File.join(@path, EXTENSIONS)).map {|filename|
        Hikkoshi::Jekyll::Post.new(filename)
      }
    end
  end
end
