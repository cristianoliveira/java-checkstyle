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
      def format(errors)
        files = errors['checkstyle']['file']

        return nil if files.empty?
        return format_single(files) unless files.is_a? Array

        format_multiple(files)
      end

      private

      def format_errors(errors)
        errors.reduce('') do |out, error|
          out + "  line: #{error['line']}:#{error['column']}"\
            " error: #{error['message']}\n"
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
