module Support
  module Path
    ##
    # Return support path relative to a given +file+
    # Files located under: /lib/plugin/pre-commit/support/checkstyle*
    #
    # @param file [String] file name
    # @return [String] formatted path
    def self.relative_to(file)
      File.expand_path("../../../../pre-commit/support/checkstyle/#{file}", __FILE__)
    end
  end
end
