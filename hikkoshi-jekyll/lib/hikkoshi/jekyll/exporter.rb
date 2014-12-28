module Hikkoshi::Jekyll
  # @example Basic Usage
  #   posts = Hikkoshi::Logdown::Importer.new("~/blog-backup/")
  #   exporter = Hikkoshi::Jekyll::Exporter.new(posts)
  #   exporter.export("~/new-blog/_posts")
  #
  # @example Customize file name
  #   posts = Hikkoshi::Logdown::Importer.new("~/blog-backup/")
  #   exporter = Hikkoshi::Jekyll::Exporter.new(posts)
  #   exporter.filename_formatter = -> (post) {
  #     "#{post.date.strftime('%F')}-#{post.slug}.md"
  #   }
  #   exporter.export("~/new-blog/_posts")
  #
  class Exporter < Hikkoshi::Exporter
    attr_accessor :filename_formatter

    def export(path)
      path = File.expand_path(path)

      @posts.each do |post|
        generate_post(post, path)
      end
    end

    # Override this method to customize file name format
    def filename_formatter(post)
      "#{post.published_at.strftime('%F')}-#{post.slug}.md"
    end

    private
    def generate_post(post, into_path)
      path = File.join(into_path, filename_formatter(post))

      File.open(path, "w") do |fout|
        fout.write format_post(post)
      end
    end

    def format_post(post)
      "#{YAML.dump(metadata(post))}\n---\n#{post.content}"
    end

    def metadata(post)
      {
        "layout" => post.layout,
        "title" => post.title,
        "published" => post.status == "published",
        "date" => post.published_at.strftime("%F %R"),
        "tags" => post.tags,
        "categories" => post.categories,
        "comments" => post.comments
      }
    end
  end
end
