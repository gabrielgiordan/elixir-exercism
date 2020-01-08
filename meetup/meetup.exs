defmodule Meetup do

  @type weekday :: :monday | :tuesday | :wednesday | :thursday | :friday | :saturday | :sunday
  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @weekdays [monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7]
  @schedules [first: 1, second: 8, third: 15, fourth: 22, teenth: 13]

  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    with {:ok, date} <- Date.new(year, month, 1) do
      date
      |> to_scheduled_day(schedule)
      |> to_next_weekday(@weekdays[weekday])
    end
  end

  def to_scheduled_day(date, :last), do: Date.add(date, Date.days_in_month(date) - 7)
  def to_scheduled_day(date, schedule), do: Date.add(date, @schedules[schedule] - 1)

  def to_next_weekday(date, weekday),
    do: Date.add(date, rem(weekday - rem(Date.day_of_week(date), 7) + 7, 7))
end
