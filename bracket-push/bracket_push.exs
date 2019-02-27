defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(string, queue \\ [])
  def check_brackets("", []), do: true
  def check_brackets(<<?(, t::binary>>, q), do: check_brackets(t, [?) | q])
  def check_brackets(<<?[, t::binary>>, q), do: check_brackets(t, [?] | q])
  def check_brackets(<<?{, t::binary>>, q), do: check_brackets(t, [?} | q])
  def check_brackets(<<h::utf8, t::binary>>, [h | q]), do: check_brackets(t, q)
  def check_brackets(<<?), _::binary>>, _), do: false
  def check_brackets(<<?], _::binary>>, _), do: false
  def check_brackets(<<?}, _::binary>>, _), do: false
  def check_brackets(<<_::utf8, t::binary>>, q), do: check_brackets(t, q)
  def check_brackets("", _), do: false
end
