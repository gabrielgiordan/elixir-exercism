defmodule TwelveDays do
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
  def verse(n) when n in 1..12 do
    "On the #{Enum.at(@days, n - 1)} day of Christmas my true love gave to me: #{gifts(n - 1)}"
  end
  defp gifts(0), do: Enum.at(@gifts, 0) <> "."
  defp gifts(1), do: Enum.at(@gifts, 1) <> ", and " <> gifts(0)
  defp gifts(n), do: Enum.at(@gifts, n) <> ", " <> gifts(n - 1)

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(s, e) when s == e, do: verse(s)
  def verses(s, e), do: verse(s) <> "\n" <> verses(s + 1, e)

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing, do: verses(1, 12)
end
