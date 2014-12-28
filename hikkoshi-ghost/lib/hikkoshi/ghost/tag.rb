require 'securerandom'

module Hikkoshi::Ghost
  class Tag
    extend Hikkoshi::Support::Slugify

    @@current_id = 1

    attr_reader :id, :name, :slug

    def initialize(name:, slug: self.class.slugify(name))
      @id = @@current_id

      @name = name
      @slug = slug

      @@current_id += 1
    end

    def as_json
      {
        id:           @id,
        name:         @name,
        slug:         @slug,
        description:  @description
      }
    end
  end
end
