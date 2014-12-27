require 'redcarpet'

class TableDowngrader
  CONVERTER = Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true)

  def initialize(content)
    @lines = content.lines
  end

  def downgrade
    flag_of_table = Array.new(@lines.size)

    parts = []
    current_part = Part.new(is_table: false)

    @lines.each_with_index do |line, i|
      current_line_is_table = line.start_with? "|"

      if current_line_is_table != current_part.table?
        # change to new part
        parts << current_part
        current_part = Part.new(is_table: current_line_is_table)
      end

      current_part << line
    end

    # last part
    parts << current_part

    parts.map(&:converted_text).join
  end

  class Part
    attr_reader :text

    def initialize(is_table:)
      @text = ""
      @is_table = is_table
    end

    def table?
      @is_table
    end

    def <<(text)
      @text << text
    end

    def converted_text
      if self.table?
        # TODO: make this optional
        convert_table(@text) + "\n<!--\n#{@text}\n-->\n"
      else
        @text
      end
    end

    def convert_table(text)
      CONVERTER.render(text)
    end
  end
end
