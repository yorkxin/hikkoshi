class Hikkoshi::Post
  attr_accessor :content

  attr_accessor :title, :slug, :status,
                :published_at, :created_at, :updated_at,
                :tags, :categories,
                :layout,
                :comments

  attr_accessor :extra_metadata

  def initialize
    @extra_metadata = OpenStruct.new

    @status = "published"
    @categories = []
    @tags = []
  end
end
