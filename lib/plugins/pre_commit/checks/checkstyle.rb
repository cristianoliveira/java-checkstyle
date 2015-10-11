require 'pre-commit/checks/shell'
require_relative '../message/extractor'
require_relative '../message/formatter'
require_relative '../support/path'

module PreCommit
  module Checks
    ##
    # Plugin implementation for pre-commit gem
    #
    # It provides a java checkstyle validation using checkstyle.jar
    # for details see:
    # lib/pre-commit/support/checkstyle
    class Checkstyle < Shell

      ##
      # Function called after pre-commit execution 
      # this method receive the +staged_files+ from git
      # 
      # @param [String] Standard git ouput with staged files
      #
      def call(staged_files)
        staged_files = staged_files.grep(/\.java$/)
        return if staged_files.empty?
        
        output = execute(args(staged_files))
        format(extract(output))
      end

      private
      
      def args(staged_files)
        [
          'java',
          jar_flag,
          config_file_flag,
          staged_files,
          config_output_format
        ]
      end

      def jar_flag
        ['-jar', Support::Path.relative_to('checkstyle-6.11-all.jar')]
      end

      def config_file_flag
        config_file ? ['-c', config_file] : []
      end
      
      def config_output_format
        ['-f','xml']
      end

      def alternate_config_file
        Support::Path.relative_to('sun_checks.xml')
      end

      def self.description
        'Runs coffeelint to detect errors'
      end

      def format(errors)
        @formatter ||= PreCommit::Message::Formatter.new
        @formatter.format errors
      end

      def extract(data)
        @extractor ||= PreCommit::Message::Extractor.new
        @extractor.extract data
      end
    end
  end
end
