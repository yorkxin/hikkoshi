require 'hikkoshi/jekyll/post'

module Hikkoshi::Logdown
  class Post < Hikkoshi::Jekyll::Post
    # Naming Troll: in Logdown 'categories' means 'tags'
    def categories=(categories)
      self.tags = categories
    end
  end
end
