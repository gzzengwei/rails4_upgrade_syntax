require 'fileutils'
require 'tempfile'
require './find_x_by_syntax.rb'

module Rails4UpgradeSyntax

  class TargetFile
    include Rails4UpgradeSyntax::FindXBySyntax

    def initialize(file)
      @changed = 0
      @file = file
    end

    def update
      puts "processing #{@file}..."

      temp_file = Tempfile.new("tempfile_#{Time.now.to_i}")

      File.open(@file, 'r') do |f|
        f.each_line do |line|
          new_line = process_line(line)
          @changed += 1 unless new_line == line
          temp_file.puts new_line
        end
        temp_file.close
      end

      FileUtils.mv(temp_file.path, @file)

      temp_file.unlink

      yield(@changed) if @changed > 0
    end

    private

    def process_line(line)
      process_list.inject(line){|k, m| method(m).call(k)}
    end

    def process_list
      [
        :process_find_by,
        :process_find_or_initialize_by,
        :process_find_or_create_by,
      ]
    end

  end

end
