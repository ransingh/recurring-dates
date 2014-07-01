require 'date'

module Recurring

  class Period
    attr_reader :start_date, :end_date, :frequency
    class << self
      def from(start_date)
        instance(start_date)
      end

      private

      def instance(start_date)
        @instance = self.new(start_date)
      end
    end

    def initialize(start_date)
      @start_date = start_date
    end

    def until(end_date, &block)
      @end_date = end_date
      dates = calculate_until_enddate
      yield dates if block
      return dates unless block
    end

    def repeat_for(frequency, &block)
      @frequency = frequency
      dates = calculate_by_frequency
      yield dates if block
      return dates unless block
    end

    private

    def calculate_until_enddate
      raise "#{__method__} method not implemented error."
    end

    def calculate_by_frequency
      raise "#{__method__} method not implemented error."
    end
  end # Period
end # Recurring
