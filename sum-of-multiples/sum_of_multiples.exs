defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors), do: sum(limit - 1, factors, factors, 0)
  defp sum(0, _, _, s), do: s
  defp sum(l, [fh | _], f_, s) when rem(l, fh) == 0, do: sum(l - 1, f_, f_, s + l)
  defp sum(l, [_ | ft], f_, s), do: sum(l, ft, f_, s)
  defp sum(l, [], f_, s), do: sum(l - 1, f_, f_, s)
end
