defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(s), do: s |> do_abbreviate() |> IO.iodata_to_binary

  defp do_abbreviate(<<f, s, t::bits>>) when f in ' ,-' and s >= ?a and s <= ?z, do: [s - 32 | do_abbreviate(t)]
  defp do_abbreviate(<<f, t::bits>>) when f >= ?A and f <= ?Z, do: [f | do_abbreviate(t)]
  defp do_abbreviate(<<_, t::bits>>), do: do_abbreviate(t)
  defp do_abbreviate(<<>>), do: <<>>
end
