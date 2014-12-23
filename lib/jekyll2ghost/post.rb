require 'yaml'
require 'ostruct'
require 'time'

class Jekyll2ghost::Post
  extend Slugify

  SEPARATOR = /---\r?\n/

  attr_reader :metadata
  attr_accessor :content
  attr_reader :title, :slug, :status, :published_at, :updated_at, :categories, :tags 
  attr_accessor :id

  def initialize(filename)
    @filename = filename
    @metadata, @content = load_file(@filename)
    set_metadata(@metadata)
  end

  def as_json
    {
      id: @id,
      title: @title,
      slug: @slug,
      markdown: @content,
      # html:         "the <i>html</i> formatted post body",
      # image:        null,
      # featured:     0, // boolean indicating featured status
      # page:         0, // boolean indicating if this is a page or post
      status: @status,
      language: "en_US",
      # meta_title:   null,
      # meta_description:null,
      # author_id:    1, // the first user created has an id of 1
      created_at: @published_at.to_i * 1_000, # in milliseconds
      # created_by:   1, // the first user created has an id of 1
      updated_at: @updated_at.to_i * 1_000, # in milliseconds
      # updated_by:   1, // the first user created has an id of 1
      published_at: @published_at.to_i * 1_000, # in milliseconds
      # published_by: 1 // the first user created has an id of 1
    }
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

  def set_metadata(metadata)
    @title = metadata.title
    @slug = determine_slug(metadata, @filename)
    @status = determine_status(metadata)
    @published_at = parse_time(metadata.date)

    if updated_at = parse_time(metadata.updated)
      @updated_at = updated_at
    else
      @updated_at = @published_at
    end

    @categories = merge_array(metadata.categories, metadata.category)
    @tags = merge_array(metadata.tags, metadata.tag)

    # TODO: comments on or off
  end

  # FIXME: did not take "permalink metadata"
  def determine_slug(metadata, filename)
    return metadata.slug if !(metadata.slug.nil? || metadata.slug.empty?)

    extracted = extract_slug_from_filename(filename)

    if extracted.empty?
      return slugify(metadata[title])
    else
      return extracted
    end
  end

  def extract_slug_from_filename(filename)
    basename = File.basename(filename, ".*")
    basename.sub(/^\d\d\d\d-\d\d-\d\d-/, "").strip
  end

  def determine_status(metadata)
    "published" if metadata.status == "published"
    "published" if metadata.published == true

    "draft" if metadata.status == "draft"
    "draft" if metadata.published == false

    # If no flag, assume published
    "published"
  end

  def merge_array(*args)
    [args].flatten.compact
  end

  def parse_time(time)
    # Assume local time zone
    Time.parse(time) rescue nil
  end
end
