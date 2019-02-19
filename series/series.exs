defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_, size) when size <= 0, do: []
  def slices(string, size, acc \\ "", list \\ [])
  def slices(<<first::utf8, string::binary>>, size, acc, _) when size > 0 do
    final = acc <> <<first::utf8>>
    <<_::utf8, next::binary>> = final
    slices(string, size - 1, final, slices(string, 1, next))
  end
  def slices(_, size, acc, list) when size == 0, do: [acc | list]
  def slices("", _, _, _), do: []
end
