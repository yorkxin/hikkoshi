require 'json'
require 'hikkoshi/ghost/post_processor/table_downgrader'

module Hikkoshi::Ghost
  class Exporter < Hikkoshi::Exporter
    extend Hikkoshi::Support::Slugify

    GHOST_DB_VERSION = "003"

    def initialize(posts)
      @posts = posts

      number_posts(@posts)

      @posts.each do |post|
        post.content = Hikkoshi::Ghost::PostProcessor::TableDowngrader.new(post.content).downgrade
      end

      @registered_tags = {} # name => Tag instance

      @posts_tags = register_posts_tags(@posts)
    end

    def export(path)
      File.open(path, "w") do |fout|
        fout.write JSON.pretty_generate({
          meta: {
            exported_on: Time.now.to_i * 1_000, # in milliseconds
            version: GHOST_DB_VERSION
          },
          data: {
            posts: @posts.map {|post| post_as_json(post) },
            tags: @registered_tags.values.map(&:as_json),
            posts_tags: @posts_tags
          }
        })
      end
    end

    private
    def number_posts(posts)
      posts.each_with_index do |post, i|
        post.extra_metadata.id = i + 1
      end
    end

    def register_posts_tags(posts)
      posts_tags = []

      posts.each do |post|
        [post.tags, post.categories].flatten.compact.each do |tag_name|
          tag = find_or_create_tag(tag_name)

          posts_tags << new_post_tag(post.extra_metadata.id, tag.id)
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
      Hikkoshi::Ghost::Tag.new({
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

    def post_as_json(post)
      {
        id: post.extra_metadata.id,
        title: post.title,
        slug: post.slug,
        markdown: post.content,
        # html:         "the <i>html</i> formatted post body",
        # image:        null,
        # featured:     0, // boolean indicating featured status
        page: (post.layout == 'page' ? 1 : 0), # boolean indicating if this is a page or post
        status: post.status,
        language: "en_US",
        # meta_title:   null,
        # meta_description:null,
        # author_id:    1, // the first user created has an id of 1
        created_at: post.published_at.to_i * 1_000, # in milliseconds
        # created_by:   1, // the first user created has an id of 1
        updated_at: post.updated_at.to_i * 1_000, # in milliseconds
        # updated_by:   1, // the first user created has an id of 1
        published_at: post.published_at.to_i * 1_000, # in milliseconds
        # published_by: 1 // the first user created has an id of 1
      }
    end

  end
end
