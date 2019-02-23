defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(w, a \\ 0)
  def score(<<>>, _), do: 0
  def score(<<h::utf8>>, a), do: a + to_score((h >= ?a && h <= ?z) && h - 32 || h)
  def score(<<h::utf8, t::binary>>, a), do: score(t, score(<<h::utf8>>, a))
  defp to_score(c) when c in 'AEIOULNRST', do: 1
  defp to_score(c) when c in 'DG', do: 2
  defp to_score(c) when c in 'BCMP', do: 3
  defp to_score(c) when c in 'FHVWY', do: 4
  defp to_score(c) when c in 'K', do: 5
  defp to_score(c) when c in 'JX', do: 8
  defp to_score(c) when c in 'QZ', do: 10
  defp to_score(c), do: 0
end
