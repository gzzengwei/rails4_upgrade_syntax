module Rails4UpgradeSyntax

  module FindXBySyntax

    def find_by_regex(type)
      /(\.#{type})_(\w+)\(([^\(]*(\(.*\))*[^\(\)]*)\)/
    end

    def find_by_x_exceptions
      %w/sql/
    end

    def process_find_by(line)
      process_find_x_by(line, :find_by)
    end

    def process_find_or_initialize_by(line)
      process_find_x_by(line, :find_or_initialize_by)
    end

    def process_find_or_create_by(line)
      process_find_x_by(line, :find_or_create_by)
    end

    def process_find_x_by(line, type)
      regex = find_by_regex(type)
      result = line.match(regex)
      return line unless result
      keys = result[2].split('_and_') 
      values = result[3].split(',').map(&:strip)
      return line unless keys.length == values.length
      return line unless (find_by_x_exceptions & keys).empty?
      line_header = result[1] + '('
      line_body = []
      line_footer = ')'
      keys.each_with_index do |key, i|
        line_body << "#{key}: #{values[i]}"
      end
      new_line = line_header + line_body.join(', ') + line_footer
      line.gsub(result[0], new_line)
    end

  end
end
