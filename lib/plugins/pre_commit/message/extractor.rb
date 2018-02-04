# frozen_string_literal: true

require 'crack'
require_relative '../domain/checkstyle'
require_relative '../domain/bad_file'

module PreCommit
  module Message
    ##
    # Responsible for extract error messages from terminal output
    class Extractor
      ##
      # Extract data from a XML formatted +terminal_output+
      #
      # @param terminal_output [String] XML formatted terminal ouput
      # @return [Domain::Checkstyle] The checkstyle
      def extract(terminal_output)
        if blank?(terminal_output) ||
           blank?(xml_content_of(terminal_output))
          return Domain::Checkstyle.good
        end

        xml_data = Crack::XML.parse(xml_content_of(terminal_output))
        files = xml_data['checkstyle']['file']

        Domain::Checkstyle.new(extract_bad_file(files))
      end

      private

      def xml_content_of(raw_output)
        raw_output[/<(.*)>/m]
      end

      def extract_bad_file(xml_files)
        return [bad_file(xml_files)] unless xml_files.is_a? Array
        xml_files.map { |e| bad_file(e) }
      end

      def bad_file(file)
        Domain::BadFile.new(file['name'], extract_errors(file))
      end

      def extract_errors(file)
        return [] if blank? file['error']
        return [file['error']] unless file['error'].is_a? Array
        file['error']
      end

      def blank?(value)
        value.nil? || value.empty?
      end
    end
  end
end
