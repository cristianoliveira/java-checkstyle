# frozen_string_literal: true

module Domain
  ##
  # Represents the Checkstyle
  # @param [Array] of bad files
  class Checkstyle
    attr_reader :bad_files

    def initialize(bad_files)
      @bad_files = bad_files
    end

    ##
    # A good checkstyle means no errors.
    #
    def good?
      @bad_files.nil? || @bad_files.empty?
    end

    ##
    # Factory for Checkstyle without errors
    def self.good
      Domain::Checkstyle.new(nil)
    end
  end
end
