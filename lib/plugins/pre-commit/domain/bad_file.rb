module Domain
  ##
  # Represents a file with checkstyle errors.
  #
  class BadFile
    attr_reader :name, :errors

    ##
    # Instanciate a default bad file.
    #
    # @param [String] name of the File
    # @param [Array] file errors
    def initialize(name, errors)
      @name = name
      @errors = errors
    end
  end
end
