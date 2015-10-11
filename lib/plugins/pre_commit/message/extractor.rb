require 'crack'

module PreCommit
  module Message 
    ##
    # Responsible for extract error messages from terminal output 
    # 
    class Extractor 
      def extract(output)
        return nil if output.nil? || output.empty?
        Crack::XML.parse(output[/<(.*)>/m])
      end
    end
  end
end
