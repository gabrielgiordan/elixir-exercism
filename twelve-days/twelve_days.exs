defmodule TwelveDays do

  @phrase [
    "On the",
    "day of Christmas my true love gave to me: "
  ]
  @days [
    "first",
    "second",
    "third",
    "fourth",
    "fifth",
    "sixth",
    "seventh",
    "eighth",
    "ninth",
    "tenth",
    "eleventh",
    "twelfth",
  ]
  @gifts [
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming",
  ]

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) when number in 1..12 do
    "#{Enum.at(@phrase, 0)} #{Enum.at(@days, number - 1)} #{Enum.at(@phrase, 1)}" <>
    for n <- number - 1..0, into: "" do
      Enum.at(@gifts, n) <>
      cond do
        n == 0 -> "."
        n == 1 -> ", and "
        true -> ", "
      end
    end
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    for v <- starting_verse..ending_verse - 1, into: "" do
      verse(v) <> "\n"
    end <> verse(ending_verse)
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing, do: verses(1, 12)
end
