module Hikkoshi::Hexo
  class Exporter < Hikkoshi::Jekyll::Exporter
    def metadata(post)
      super.merge({
        "permalink" => post.slug
      })
    end
  end
end
