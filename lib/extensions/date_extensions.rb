class Date
  def is_free?
    [6,7].include? self.cwday
  end

  def next_working_day
    wd = self + 1
    return wd.is_free? ? wd.next_working_day : wd
  end
end

module ActiveSupport
  module CoreExtensions
    module Numeric
      module Time

        def working_days_from_now
          end_date = ::Date.today + self
          free_days = (::Date.today..end_date).select{|d| d.is_free?}.size
          return (result = end_date + free_days).is_free? ? result.next_working_day : result
        end

        alias :working_day_from_now :working_days_from_now
      end
    end
  end
end


