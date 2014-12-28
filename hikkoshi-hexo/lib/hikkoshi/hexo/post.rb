require 'hikkoshi/jekyll/post'

module Hikkoshi::Hexo
  class Post < Hikkoshi::Jekyll::Post
    def updated=(updated)
      @updated_at = parse_time(updated)
    end

    # In Hexo "slug" is called "permalink"
    def permalink=(permalink)
      @slug = permalink
    end

    # In Hexo it takes the whole file name as slug, instead of date-prefixed
    def post_process_slug
      if @slug.nil? || @slug.blank?
        @slug = slug_from_filename(filename, strip_date: false)
      end
    end
  end
end
