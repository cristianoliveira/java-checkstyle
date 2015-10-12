module Domain
  ##
  # Represents the
  class Checkstyle
    attr_reader :bad_files

    def initialize(bad_files)
      @bad_files = bad_files
    end

    ##
    # An Checkstyle empty means no errors.
    #
    def empty?
      @bad_files.nil? || @bad_files.empty?
    end

    ##
    # Factory for Checkstyle without errors
    def self.empty
      Domain::Checkstyle.new(nil)
    end
  end
end
