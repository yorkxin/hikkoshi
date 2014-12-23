require 'json'
require 'jekyll2ghost/table_downgrader'

class Jekyll2ghost::Exporter
  extend Slugify

  VERSION = "003"

  def initialize(dir, current:)
    @posts = load_posts(dir)
    number_posts(@posts)

    @posts.each do |post|
      post.content = TableDowngrader.new(post.content).downgrade
    end

    @registered_tags = {} # name => Tag instance

    @posts_tags = register_posts_tags(@posts)
  end

  def to_json
    JSON.pretty_generate({
      meta: {
        exported_on: Time.now.to_i * 1_000, # in milliseconds
        version: VERSION
      },
      data: {
        posts: @posts.map(&:as_json),
        tags: @registered_tags.values.map(&:as_json),
        posts_tags: @posts_tags
      }
    })
  end

  private

  def load_posts(dir)
    Dir.glob(File.join(dir, "**/*")).map {|file| Jekyll2ghost::Post.new(file) }
  end

  def number_posts(posts)
    posts.each_with_index do |post, i|
      post.id = i + 1
    end
  end

  def register_posts_tags(posts)
    posts_tags = []

    posts.each do |post|
      [post.tags, post.categories].flatten.compact.each do |tag_name|
        tag = find_or_create_tag(tag_name)

        posts_tags << new_post_tag(post.id, tag.id)
      end
    end

    posts_tags
  end

  def find_or_create_tag(name)
    slug = self.class.slugify(name)

    if tag = @registered_tags[slug]
      return tag
    else
      tag = new_tag(name, slug)

      @registered_tags[slug] = tag

      return tag
    end
  end

  def new_tag(name, slug)
    Jekyll2ghost::Tag.new({
      slug: slug,
      name: name
    })
  end

  def new_post_tag(post_id, tag_id)
    {
      post_id: post_id,
      tag_id: tag_id
    }
  end
end
