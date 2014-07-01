module Recurring
  class Monthly < Period

    def from_current_month
      from(DateTime.now)
    end

    def from_next_month
      from(DateTime.now.next_month)
    end

    private

    def calculate_until_enddate()
      raise EndDateNotDefineError.new("recurring dates cannot be calulated without end date.") unless @end_date
      @frequency = @end_date.day - @start_date.day
      calculate_by_frequency()
    end

    def calculate_by_frequency()
      raise RepetitionFrequencyNotDefineError.new("recurring dates cannot be calulated without repetion frequency.") unless @frequency
      dates = [@start_date]
      start = @start_date
      @frequency.times.map do
        start = start >> 1.month
        dates << start
      end
    end
  end # Monthly
end # Recurring

