defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  @on "on the wall"
  def verse(n), do: "#{capitalize_first(beers(n))} #{@on}, #{beers(n)}.\n#{action(n)}, #{beers(n - 1)} #{@on}.\n"
  defp beers(-1), do: beers(99)
  defp beers(n), do: "#{how_many(n)} bottle#{plural(n)} of beer"
  defp action(0), do: "Go to the store and buy some more"
  defp action(n), do: "Take #{pronoun(n)} down and pass it around"
  defp plural(1), do: ""
  defp plural(_), do: "s"
  defp pronoun(1), do: "it"
  defp pronoun(_), do: "one"
  defp how_many(0), do: "no more"
  defp how_many(n), do: n
  defp capitalize_first(<<h::utf8, t::binary>>) when h >= ?a and h <= ?z, do: <<h - 32, t::binary>>
  defp capitalize_first(s), do: s

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    Enum.map_join(range, "\n", &verse/1)
  end

end
