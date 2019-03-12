defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2, s \\ 0)
  def hamming_distance([h|t1], [h|t2], s), do: hamming_distance(t1, t2, s)
  def hamming_distance([_|t1], [_|t2], s), do: hamming_distance(t1, t2, s + 1)
  def hamming_distance([], [], s), do: {:ok, s}
  def hamming_distance(_, _, _), do: {:error, "Lists must be the same length"}
end
