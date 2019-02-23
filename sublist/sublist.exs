defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist
  def compare(a, b) when length(a) < length(b), do: contains?(a, b) && :sublist || :unequal
  def compare(a, b), do: contains?(b, a) && :superlist || :unequal
  defp contains?(a, b), do: contains?(a, b, false, a, b)
  defp contains?([], [], _, _, _), do: true
  defp contains?([], _, r, _, _), do: r
  defp contains?(_, [], _, _, _), do: false
  defp contains?([h | at], [h | bt], _, a_, b_), do: contains?(at, bt, true, a_, b_)
  defp contains?(_, _, true, a_, [_ | b_t]), do: contains?(a_, b_t, false, a_, b_t)
  defp contains?(_, [_ | bt], _, a_, b_), do: contains?(a_, bt, false, a_, b_)
end
