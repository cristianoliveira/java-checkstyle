# frozen_string_literal: true

module Domain
  ##
  # Represents a file with style errors.
  #
  class BadFile
    attr_reader :name, :errors

    ##
    # Instanciate a default bad file.
    #
    # @param [String] The File name
    # @param [Array] The errors
    def initialize(name, errors)
      @name = name
      @errors = errors
    end
  end
end
