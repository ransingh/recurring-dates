module Recurring
  class Yearly < Period

    def from_current_year
      from(DateTime.now) # should be reset to 1 Jan yyyy 00:00:00
    end

    def from_next_year
      from(DateTime.now.next_year)# should be reset to 1 Jan yyyy+1 00:00:00
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
        start = start >> 12.months
        dates << start
      end
    end
  end # Yearly
end # Recurring

