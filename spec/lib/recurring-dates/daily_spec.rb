require 'spec_helper'

describe Recurring::Daily do
  before do
    Timecop.freeze(Time.local(2014,7,1,10,00,00))
  end

  describe  ".from_today" do
    subject { Recurring::Daily.from_today }
    it "should return an daily date with starting date set for today" do
      subject.start_date == DateTime.now
    end
  end

  describe ".from_tomorrow" do
    subject { Recurring::Daily.from_today }
    it "should return an daily date with starting date set for tomorrow" do
      subject.start_date == DateTime.now.next_day
    end
  end

  describe "#until" do
    context  "starting from today" do
      subject { Recurring::Daily.from_today }

      it "does return all recurring dates on daily basis from today until end date" do
        dates = subject.until(DateTime.now + 10.days)
        10.downto(0).each do |i|
          expect(dates).to include(DateTime.now + i.days)
        end
      end

      context "when a block is provided" do
        it "does yield to the block with all recurring dates on daily basis from today until end date" do
          expect { |b|
            subject.until(DateTime.now + 10.days, &b)
          }.to yield_successive_args(get_dates(DateTime.now, 11))
        end
      end

      context "when end date is same as start date" do
        it "has only today's date" do
          expect(subject.until(DateTime.now)).to eq([DateTime.now])
        end
      end

      context "when end date is before start date" do
        it "has only today's date" do
          expect(subject.until(DateTime.now - 1.day)).to eq([])
        end
      end
    end

    context  "starting from tomorrow" do
      subject { Recurring::Daily.from_tomorrow }

      it "should return all recurring dates on daily basis from tomorrow until end date" do
        dates = subject.until(DateTime.now + 10.days)

        expect(dates).not_to include(DateTime.now)

        10.downto(1).each do |i|
          expect(dates).to include(DateTime.now + i.days)
        end
      end

      context "when a block is provided" do
        it "should yield to the block with all recurring dates on daily basis from tomorrow until end date" do
          expect { |b|
            subject.until(DateTime.now + 10.days, &b)
          }.to yield_successive_args(get_dates(DateTime.now+1.days,10))
        end
      end
    end
  end

  describe "#repeat_for" do
    context  "starting from today" do
      subject { Recurring::Daily.from_today }

      it "should return as many recurring dates on daily basis from today as repetition frequency" do
        0.upto(9).each do |i|
          expect(subject.repeat_for(10)).to include(DateTime.now + i.days)
        end
        expect(subject.repeat_for(10).size).to eq(10)
      end

      context "when a block is provided" do
        it "should return as many recurring dates on daily basis from today as repetition frequency" do
          expect{|b|
            subject.repeat_for(2, &b)
          }.to yield_successive_args(get_dates(DateTime.now, 2))
        end
      end
    end

    context  "starting from tomorrow" do
      subject { Recurring::Daily.from_tomorrow }

      it "should return as many recurring dates on daily basis from tomorrow as repetition frequency" do
        0.upto(9).each do |i|
          expect(subject.repeat_for(10)).to include(DateTime.now.next + i.days)
        end
        expect(subject.repeat_for(10).size).to eq(10)
      end

      context "when a block is provided" do
        it "should return as many recurring dates on daily basis from tomorrow as repetition frequency" do
          expect{|b|
            subject.repeat_for(2, &b)
          }.to yield_successive_args(get_dates(DateTime.now.next, 2))
        end
      end
    end
  end

  def get_dates(from, count, inclusive = true)
    count.times.reduce([]){|dates,i| dates << (from + i.days) }
  end
end
