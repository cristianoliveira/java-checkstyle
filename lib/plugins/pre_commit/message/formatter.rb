module PreCommit
  module Message
    ##
    # Responsible for format a given output
    class Formatter
      ##
      # Format output for a given +errors+ details
      #
      # @param [Hash] JSON errors details
      # @return [String] formatted output (may return nil)
      # @raise ArgumentError when input is empty
      #
      def format(errors)
        throw ArgumentError.new if errors.nil? || errors.empty?

        files = errors['checkstyle']['file']

        return nil if files.empty?
        return format_single(files) unless files.is_a? Array

        format_multiple(files)
      end

      private

      def line(error)
        "  line: #{error['line']}:#{error['column']}"\
          " error: #{error['message']}\n"
      end

      def format_errors(errors)
        return line(errors) unless errors.is_a? Array
        errors.reduce('') do |out, error|
          out + line(error)
        end
      end

      def format_single(file)
        "File errors: #{file['name']} \n" + format_errors(file['error'])
      end

      def format_multiple(files)
        files.reduce('') { |a, e| a + format_single(e) }
      end
    end
  end
end
