module Recurring
  class Weekly < Period
    WEEK = 7.days

    def from_current_week
      from(DateTime.now)
    end

    def from_next_week
      days_left_in_this_week =  7 - (DateTime.now).wday
      from(DateTime.now + days_left_in_this_week + 1.day)
    end

    def week_from_today
      from(DateTime.now + WEEK)
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
        start = start + WEEK
        dates << start
      end
    end
  end # Weekly
end # Recurring

