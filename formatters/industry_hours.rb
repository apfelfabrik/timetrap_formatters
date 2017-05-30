class Timetrap::Formatters::IndustryHours

  def initialize(entries)
    @entries = entries
  end

  def groups_by_day(entries)
    entries.group_by { |e| e.start.strftime "%a %b %e, %Y" }
  end

  def seconds_to_industry_hours(seconds)

    minutes = (seconds / 60.0).floor
    if (seconds % 60 != 0)
      minutes = minutes + 1
    end

    ((minutes / 60.0) * 100.0).floor / 100.0
  end

  def output

    grand_total = 0
    print "    Day                 Hours\n"

    groups_by_day(@entries).each do |day, group|

      print "    #{day}  " #  (#{group.length} entries)"

      hours = (group.map do |e|
        seconds_to_industry_hours(e.end - e.start)
      end.inject :+).round(2)
      print "  #{hours}"

      grand_total += hours

      print "\n"
      STDOUT.flush
    end


    print "    -----------------------------\n"
    print "    Total:              #{grand_total.round(2)}"
    ""
  end

end


