require 'yaml'
require 'ostruct'
require 'time'

module Hikkoshi::Jekyll
  class Post < Hikkoshi::Post
    include Hikkoshi::Support::TimeParser
    include PostProcessor::Slug

    SEPARATOR = /---\r?\n/

    def initialize(filename)
      super()

      @filename = filename
      @original_metadata, @content = load_file(@filename)

      cast_metadata
      post_process
    end

    def slug=(slug)
      @slug = slug
    end

    def published=(published)
      if published == false
        @status = "draft"
      else
        # by default it is published
        @status = "published"
      end
    end

    def date=(date)
      @published_at = parse_time(date)
    end

    def categories=(categories)
      @categories += categories if categories.is_a? Array
    end

    def category=(category)
      @categories << category
    end

    def tags=(tags)
      @tags += tags if tags.is_a? Array
    end

    private
    def load_file(filename)
      fulltext = File.read(filename)

      # Hexo does not insert "---" at the first line.
      # This hack is to unify the formats of all the files
      fulltext.sub!(/^#{SEPARATOR}/, '')

      raw_metadata, content = fulltext.split(SEPARATOR, 2)

      metadata = OpenStruct.new(YAML.load(raw_metadata))

      return [metadata, content]
    end

    def cast_metadata
      @original_metadata.each_pair do |name, value|
        if self.respond_to?(:"#{name}=")
          self.send(:"#{name}=", value)
        else
          STDERR.puts "Unknown property: #{name}"
        end
      end
    end

    def post_process
      post_process_slug
      post_process_time
    end

    def post_process_slug
      if @slug.nil? || @slug.blank?
        @slug = slug_from_filename(@filename) or slug_from_title(@title)
      end
    end

    def post_process_time
      @published_at ||= date_from_filename(@filename)

      # default values for created / updated
      @created_at ||= @published_at
      @updated_at ||= @published_at
    end
  end
end
