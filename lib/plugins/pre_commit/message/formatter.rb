module PreCommit
  module Message
    class Formatter
      def format(output)
        p output
        return nil unless output
        output.gsub(/(   *)|^\w+(.*)[.|\n]/,'')
      end
    end
  end
end
