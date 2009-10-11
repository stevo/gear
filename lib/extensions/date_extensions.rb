class Date #:nodoc:
  # returns true, if date given is holiday
  def is_free?
    [6,7].include? self.cwday
  end

  # returns next working day for date given
  def next_working_day
    wd = self + 1
    return wd.is_free? ? wd.next_working_day : wd
  end
end

module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Numeric #:nodoc:
      module Time #:nodoc:

        # returns a working day _n_ working days from now
        # i.e. _5.working_days_from_now_::
        #
        # method is aliased with _working_day_from_now_::
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


