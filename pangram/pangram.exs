defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """
  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence, set \\ %MapSet{})
  def pangram?(<<>>, s), do: MapSet.size(s) == 26
  def pangram?(<<h::utf8, t::binary>>, s) when h >= ?a and h <= ?z, do: pangram?(t, MapSet.put(s, h))
  def pangram?(<<h::utf8, t::binary>>, s) when h >= ?A and h <= ?Z, do: pangram?(t, MapSet.put(s, h + 32))
  def pangram?(<<_::utf8, t::binary>>, s), do: pangram?(t, s)
end
