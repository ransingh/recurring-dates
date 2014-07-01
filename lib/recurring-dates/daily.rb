# Recurring::Daily.from_today.unitl(date)
#
# Recurring::Daily.from_tomorrow.unitl(date)
#
# Recurring::Daily.from_tomorrow.unitl("")
#
# Recurring::Daily.from_today.repeat_for(9.days)
#
#
module Recurring
  class Daily < Period
    class << self
      def from_today
        from(DateTime.now)
      end

      def from_tomorrow
        from(DateTime.now.next_day)
      end
    end

    private

    def calculate_until_enddate()
      raise EndDateNotDefineError.new("recurring dates cannot be calulated without end date.") unless @end_date
      @frequency = @end_date < @start_date  ? 0 : (@end_date.day - @start_date.day + 1)
      calculate_by_frequency()
    end

    def calculate_by_frequency()
      raise RepetitionFrequencyNotDefineError.new("recurring dates cannot be calulated without repetion frequency.") unless @frequency

      return [] if @frequency <= 0

      dates = [@start_date]
      start = @start_date
      (@frequency -1).times.each do |i|
        start = start.next
        dates << start
      end
      dates
    end
  end  # Daily
end # Recurring
