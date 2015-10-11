module PreCommit
  module Message 
    class Formatter
      ##
      # Format output for a given +errors+ details
      # @param [Hash] Errors details
      # @return [String] formatted output (may return nil)
      # 
      def format(errors)
        files = errors['checkstyle']['file']
        
        return nil if files.empty?
        return format_single(files) unless files.is_a? Array

        format_multiple files
      end

      private 

      def format_errors(errors)
        errors.reduce(String.new) do |output, error| 
          output += "  line: #{error['line']}:#{error['column']} error: #{error['message']} \n"
        end
      end

      def format_single(file)
          output = "File errors: #{file['name']} \n"
          output + format_errors(file['error'])
      end

      def format_multiple(files)
        files.reduce(String.new) {|output, file| output += format_single(file)}
      end
    end
  end
end
