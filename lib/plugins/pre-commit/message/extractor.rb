require 'crack'

module PreCommit
  module Message
    ##
    # Responsible for extract error messages from terminal output
    class Extractor
      EMPTY = { 'checkstyle' => { 'file' => [] } }

      ##
      # Extract data from a XML formatted +output+
      #
      # @param output [String] Xml formatted ouput
      # @return [Hash]
      def extract(output)
        return EMPTY if output.nil? || output.empty?
        Crack::XML.parse(xml_content(output))
      end

      private

      def xml_content(raw_output)
        raw_output[/<(.*)>/m]
      end
    end
  end
end
