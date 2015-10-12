require 'crack'
require_relative '../domain/checkstyle'
require_relative '../domain/bad_file'

module PreCommit
  module Message
    ##
    # Responsible for extract error messages from terminal output
    class Extractor
      ##
      # Extract data from a XML formatted +output+
      #
      # @param output [String] Xml formatted ouput
      # @return [Hash]
      def extract(output)
        return Domain::Checkstyle.empty if output.nil? || output.empty?
        xml_data = Crack::XML.parse(xml_content(output))

        files = xml_data['checkstyle']['file']

        Domain::Checkstyle.new(extract_bad_file(files))
      end

      private

      def xml_content(raw_output)
        raw_output[/<(.*)>/m]
      end

      def extract_bad_file(xml_files)
        return [create_bad_file(xml_files)] unless xml_files.is_a? Array

        xml_files.reduce([]) { |a, e| a.push(create_bad_file(e)) }
      end

      def create_bad_file(file)
        Domain::BadFile.new(file['name'], extract_errors(file['error']))
      end

      def extract_errors(xml_errors)
        return [] if xml_errors.nil? || xml_errors.empty?
        return [xml_errors] unless xml_errors.is_a? Array

        xml_errors
      end
    end
  end
end
