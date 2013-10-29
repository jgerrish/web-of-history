module HistoricalDate

  # method to convert a Date object to a readable date object with BC / AD
  def as_historical_date(precision='D')
    if year < 0
      y = (-year).to_s + " BC"
    else
      y = year.to_s + " AD"
    end
    m = strftime('%b')
    d = strftime('%e')

    full_date = self.to_s

    if precision == 'Y'
      full_date = y
    elsif precision == 'M'
      full_date = m + " " + y
    elsif precision == 'D'
      full_date = m + ", " + d + " " + y
    end

    full_date
  end

  def as_timelinejs_date
    strftime("%Y,%m,%d")
  end

end
