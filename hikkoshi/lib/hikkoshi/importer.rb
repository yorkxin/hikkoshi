class Hikkoshi::Importer
  attr_reader :posts

  def initialize(source)
    raise NotImplementedError
  end
end
