require 'pre-commit/checks/shell'
require_relative '../message/formatter'

module PreCommit
  module Checks
    class Checkstyle < Shell
      def call(staged_files)
        staged_files = staged_files.grep(/\.java$/)
        return if staged_files.empty?

        args = ['java', jar_flag, config_file_flag, staged_files]
        formatter.format(execute(args))
      end

      def jar_flag
        ['-jar', support_path('checkstyle-6.11-all.jar')]
      end

      def support_path(file)
        File.expand_path("../../../../pre-commit/support/checkstyle/#{file}", __FILE__)
      end

      def config_file_flag
        config_file ? ['-c', config_file] : []
      end

      def alternate_config_file
        support_path('sun_checks.xml')
      end

      def self.description
        'Runs coffeelint to detect errors'
      end

      def formatter
        @formatter ||= PreCommit::Message::Formatter.new
      end
    end
  end
end
