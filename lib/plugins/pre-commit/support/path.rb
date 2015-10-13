module Support
  ##
  # Responsible for provide relative paths to support files
  # Files located under: /lib/plugin/pre-commit/support/checkstyle*
  module Path
    ##
    # Return support path relative to a given +file+
    #
    # @param file [String] file name
    # @return [String] formatted path
    def self.relative_to(file)
      File.expand_path(
        "../../../../resources/checkstyle/#{file}",
        __FILE__
      )
    end
  end
end
