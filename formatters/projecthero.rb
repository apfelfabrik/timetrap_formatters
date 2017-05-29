class Timetrap::Formatters::Projecthero
  def initialize(entries)
    @entries = entries
  end

  def groups_by_day(entries)
    entries.group_by { |e| e.start.strftime "%a %b %e, %Y" }
  end

  def groups_by_note(entries)
    entries.group_by { |e| e.note.strip }
  end

  def output

    grand_total = 0

    groups_by_day(@entries).each do |day, group|

      puts "#{day} (#{group.length} entries)"
      puts

      groups_by_note(group).each do |note, agg|
        total_seconds = (agg.map {|e| e.end - e.start}.inject :+)
        seconds_in_workday = 8 * 60 * 60
        workday_part = (100 * total_seconds / seconds_in_workday).ceil.to_f / 100
        puts "  #{workday_part} - #{note}"

        grand_total += workday_part
      end

      puts
    end

    puts "Total: #{grand_total}"
    ""
  end
end
