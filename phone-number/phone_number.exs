defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw), do: unformat(raw, 0, <<>>)

  @invalid "0000000000"
  defp unformat(_, 11, <<h, t::bits>>), do: h == ?1 && unformat(<<t::bits>>) || @invalid
  defp unformat(<<h, t::bits>>, l, n) when h >= ?0 and h <= ?9, do: unformat(t, l + 1, <<n::bits, h>>)
  defp unformat(<<h, _::bits>>, _, _) when h >= ?a and h <= ?z or h >= ?A and h <= ?Z, do: @invalid
  defp unformat(<<_, t::bits>>, l, n), do: unformat(t, l, n)
  defp unformat(<<>>, l, n), do: l >= 10 && unformat(n) || @invalid
  defp unformat(<<h1, _::binary-2, h2, _::bits>> = n), do: h1 >= ?2 and h2 >= ?2 && n || @invalid

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw), do: <<number(raw)::binary-3>>

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    <<a::binary-3, e::binary-3, s::bits>> = number(raw)
    <<?(, a::bits, ?), ?\s, e::bits, ?-, s::bits>>
  end

end
