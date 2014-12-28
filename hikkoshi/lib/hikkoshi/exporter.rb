class Hikkoshi::Exporter
  def initialize(posts)
    @posts = posts
  end

  def export(target)
    raise NotImplementedError
  end
end
