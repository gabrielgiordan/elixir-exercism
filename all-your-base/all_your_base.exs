defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """
  @spec convert(list, integer, integer) :: list
  def convert(digits, base_a, base_b)
  def convert([], _, _), do: nil
  def convert(_, a, b) when a < 2 or b < 2, do: nil
  def convert(d, a, b), do: d |> to_decimal(a) |> from_decimal(b)

  defp to_decimal(d, b), do: to_decimal(d, b, length(d) - 1, 0)
  defp to_decimal([], _, _, acc), do: trunc(acc)
  defp to_decimal([h | _], b, _, _) when h < 0 or h >= b, do: nil
  defp to_decimal([0 | t], b, i, acc), do: to_decimal(t, b, i - 1, acc)
  defp to_decimal([h | t], b, i, acc), do: to_decimal(t, b, i - 1, acc + h * :math.pow(b, i))

  defp from_decimal(n, b, d \\ [])
  defp from_decimal(nil, _, _), do: nil
  defp from_decimal(0, _, []), do: [0]
  defp from_decimal(0, _, d), do: d
  defp from_decimal(n, b, d), do: from_decimal(div(n, b), b, [rem(n, b) | d])
end
