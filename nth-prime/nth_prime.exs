defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise ArgumentError
  def nth(1), do: 2
  def nth(count) do
    Stream.iterate(3, & &1 + 2)
    |> Stream.filter(&prime?/1)
    |> Stream.take(count - 1)
    |> Stream.take(-1)
    |> Enum.at(0)
  end

  defp prime?(n), do: prime?(n, 3)
  defp prime?(n, q) when n < q * q, do: true
  defp prime?(n, q) when rem(n, q) == 0, do: false
  defp prime?(n, q), do: prime?(n, q + 2)
end
