module Slugify
  RE_INVALID = /[\s[:punct:]]+/

  def slugify(text, delimiter="-")
    text.split(RE_INVALID).join(delimiter).downcase
  end
end
