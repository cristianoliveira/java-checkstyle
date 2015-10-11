module PreCommit
  module Message
    ##
    # Responsible for formating the given error message output
    # keeping only the message errors generated for checkstyle.java
    class Formatter
      def format(output)
        return nil if output.nil? || output.empty?
        output.gsub(/(   *)|^\w+(.*)[.|\n]/,'')
      end
    end
  end
end
