#!/usr/bin/env ruby

require './target_file.rb'

module Rails4UpgradeSyntax

  class UpdateSyntax

    def initialize
      puts "Please input filename(s) or folder" and return unless ARGV.any?

      assigning_variables

      updating_syntax

      show_results
    end
    
    private

    def assigning_variables
      @file_counts, @change_count = 0, 0
      @filenames = []
      ARGV.each do |arg|
        if File.file?(arg)
          @filenames << arg
        elsif File.directory?(arg)
          @filenames += Dir.glob(File.join(arg, '**', "*.{rb,rake,erb}"))
        end
      end
    end

    def updating_syntax
      @filenames.each do |f|
        TargetFile.new(f).update do |count|
          update_count(count)
        end
      end
    end

    def update_count(count)
      @file_counts += 1
      @change_count += count
    end

    def show_results
      puts "\n==================================\n"
      puts "#{@change_count} place(s) of code has been updated in #{@file_counts} file(s)."
    end
  end

  UpdateSyntax.new
end
